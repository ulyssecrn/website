+++
title = "Homelab: a declarative NixOS fleet"
description = "One NixOS flake for 5 hosts across x86_64 and aarch64, with Prometheus and Grafana monitoring. This site is served from it."
weight = 30
template = "project.html"

[extra]
featured = true
tags = ["Nix", "Linux", "Monitoring"]
image = "cover.jpg"
image_alt = "Left: the silver Power Mac G5 case that holds the LLM server. Right: the ZFS storage server through its glass side panel"
image_caption = "Left, the LLM server inside a gutted Power Mac G5. Right, the ZFS storage server."
+++

All my machines are defined in one public NixOS flake: [github.com/ulyssecrn/nixos-config](https://github.com/ulyssecrn/nixos-config).

{{ <diagram file="fleet-themed.svg" caption="One flake, five hosts. Every machine is rebuilt from the same repository." /> }}

- **5 hosts across x86_64 and aarch64:** a ZFS storage server (Nextcloud, Immich, Paperless) with a GTX 1080 Ti for Immich's machine learning and Jellyfin transcoding, an LLM inference server (llama.cpp, LibreChat, SearXNG), a Raspberry Pi DNS resolver (Pi-hole), my laptop, and an M1 MacBook on Asahi Linux.
- **The LLM server** lives in a Power Mac G5 case that I gutted to fit an ATX motherboard, an ATX power supply and an RTX 3090.
- **Services** sit behind a Caddy reverse proxy, with restic backups.
- **Monitoring:** a Prometheus, Grafana and Alertmanager stack, written as NixOS modules. The 13 alert rules are validated by promtool at build time, so a bad rule fails the build.

## This site

This site is a Zola project packaged as a Nix flake. The fleet's config takes it as an input, Caddy serves the built files from the Nix store, and a Pangolin tunnel makes it public without opening a port at home. The [source](https://github.com/ulyssecrn/website) is public.
