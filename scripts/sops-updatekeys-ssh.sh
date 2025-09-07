#!/usr/bin/env bash
SOPS_AGE_KEY=$(sudo ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key) sops --config ../.sops.yaml updatekeys ../secrets.yaml
