#!/usr/bin/env bash
EDITOR=vim SOPS_AGE_KEY_FILE=/tmp/nix-age.txt nix run nixpkgs#sops $@
