# NixOS module: serve the built site with Caddy on a local port.
# TLS and the public name (ulysse.corne.sh) live at Pangolin, not here.
self:
{ config, lib, pkgs, ... }:

let
  cfg = config.services.ulysse-site;
in
{
  options.services.ulysse-site = {
    enable = lib.mkEnableOption "the ulysse.corne.sh static site";

    package = lib.mkOption {
      type = lib.types.package;
      default = self.packages.${pkgs.stdenv.hostPlatform.system}.default;
      description = "The built site (a directory of static files).";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 8090;
      description = "Plain-HTTP port Caddy serves the site on.";
    };

    firewallInterface = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "pangolin";
      description = "Open the port on this interface only. null leaves the firewall alone.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.caddy.enable = true;
    services.caddy.virtualHosts."http://:${toString cfg.port}".extraConfig = ''
      root * ${cfg.package}
      encode zstd gzip

      # Every file in the Nix store has mtime 1, and Caddy's ETag is mtime plus
      # size, so an edited file of the same size would keep its ETag and
      # browsers would be told their stale copy is fine. Send no validators.
      header -ETag
      header -Last-Modified

      # Processed images and fonts have content-hashed or never-changing names.
      @immutable path /processed_images/* /fonts/*
      header @immutable Cache-Control "public, max-age=31536000, immutable"
      @mutable not path /processed_images/* /fonts/*
      header @mutable Cache-Control "public, max-age=300"

      file_server

      handle_errors {
        rewrite * /404.html
        file_server
      }
    '';

    networking.firewall.interfaces = lib.mkIf (cfg.firewallInterface != null) {
      ${cfg.firewallInterface}.allowedTCPPorts = [ cfg.port ];
    };
  };
}
