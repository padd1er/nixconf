#!/usr/bin/env bash
EDITOR=vim SOPS_AGE_KEY_FILE=/tmp/age-keys.txt nix run nixpkgs#sops $@
