#!/usr/bin/env bash
EDITOR=nvim SOPS_AGE_KEY_FILE=/tmp/nix-age.txt nix run nixpkgs#sops $@
