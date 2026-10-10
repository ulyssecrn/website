# ulysse.corne.sh

My portfolio: the boards I design, the firmware I write, and the work behind them.

Built with [Zola](https://www.getzola.org/) and packaged as a Nix flake. It is self-hosted on my NixOS fleet: [nixos-config](https://github.com/ulyssecrn/nixos-config) takes this flake as an input, Caddy serves the built site from the Nix store, and a Pangolin tunnel makes it public without opening a port at home.

## Develop

```sh
nix develop -c zola serve --drafts   # http://127.0.0.1:1111
nix build                            # the built site, in ./result
nix flake check                      # build, Caddy config validation, copy style
```

## Layout

- `content/projects/`: personal projects. `featured = true` puts one on the home page.
- `content/experience/`: one section per employer or lab, one page per project.
- `content/notes/`: short write-ups and riddles.
- `templates/components.html`: the cards, figures and the lazy KiCanvas viewer.
- `nix/module.nix`: the NixOS module that serves the site (`services.ulysse-site`).

CI runs `nix flake check` on x86_64 and aarch64 for every push.
