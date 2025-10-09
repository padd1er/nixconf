#!/usr/bin/env bash
# Edit secrets.yaml using YubiKey for decryption
SOPS_AGE_KEY=$(age-plugin-yubikey --identity | grep "^AGE-PLUGIN-YUBIKEY-" | head -1) sops --config ../.sops.yaml ../secrets.yaml
