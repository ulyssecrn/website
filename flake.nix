{
  description = "ulysse.corne.sh, Ulysse Corne's hardware portfolio (Zola static site)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      # The built site: a store path containing plain HTML/CSS/images.
      # nixos-config serves it with Caddy file_server.
      packages = forAllSystems (pkgs: {
        default = pkgs.stdenvNoCC.mkDerivation {
          pname = "ulysse-corne-site";
          version = self.shortRev or self.dirtyShortRev or "dev";
          src = self;
          nativeBuildInputs = [ pkgs.zola ];
          # load_data initialises an HTTPS client even for local files and panics
          # without a CA bundle. The sandbox still has no network access.
          SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
          buildPhase = ''
            runHook preBuild
            zola build --output-dir $out
            runHook postBuild
          '';
          dontInstall = true;
          dontFixup = true;
        };
      });

      checks = forAllSystems (pkgs: {
        build = self.packages.${pkgs.stdenv.hostPlatform.system}.default;

        # Evaluate the NixOS module and have Caddy validate the config it generates.
        nixos-module =
          let
            sys = nixpkgs.lib.nixosSystem {
              modules = [
                self.nixosModules.default
                {
                  nixpkgs.hostPlatform = pkgs.stdenv.hostPlatform.system;
                  services.ulysse-site = { enable = true; firewallInterface = "pangolin"; };
                  boot.loader.grub.enable = false;
                  fileSystems."/".device = "none";
                  system.stateVersion = "26.05";
                }
              ];
            };
          in
          pkgs.runCommand "caddy-validate" { } ''
            # The real config logs under /var/log, which the sandbox cannot create.
            export HOME=$TMPDIR
            sed "s|/var/log/caddy|$TMPDIR/log|g" ${sys.config.services.caddy.configFile} > Caddyfile
            ${pkgs.caddy}/bin/caddy validate --adapter caddyfile --config Caddyfile > $out 2>&1 || { cat $out; exit 1; }
          '';

        # House style for the copy: no em dashes and no semicolons in prose.
        copy-style = pkgs.runCommand "copy-style" { src = self; } ''
          cd $src
          # Literal byte match: the sandbox runs in the C locale.
          rc=0
          grep -rnF --include='*.md' -e '—' -e ';' content/ || rc=$?
          if [ "$rc" -eq 0 ]; then echo "Em dash or semicolon found in content/ (see above)"; exit 1; fi
          if [ "$rc" -ne 1 ]; then echo "grep failed"; exit 1; fi
          touch $out
        '';
      });

      nixosModules.default = import ./nix/module.nix self;

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC { packages = [ pkgs.zola ]; };
      });
    };
}
