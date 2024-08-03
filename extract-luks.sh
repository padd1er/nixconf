#!/usr/bin/env bash
SOPS_AGE_KEY_FILE=/tmp/age-keys.txt nix run nixpkgs#sops -- --decrypt --extract "['luks_root']" secrets.yaml > /tmp/nix-root.key
SOPS_AGE_KEY_FILE=/tmp/age-keys.txt nix run nixpkgs#sops -- --decrypt --extract "['luks_home']" secrets.yaml > /tmp/nix-home.key
