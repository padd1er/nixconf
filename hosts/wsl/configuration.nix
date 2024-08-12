# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config
, lib
, pkgs
, inputs
, outputs
, system
, ...
}:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../../nix-modules/bundles/default.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  networking.hostName = "wsl-nixos";

  sys-nixos.enable = lib.mkForce true;
  sys-system.enable = lib.mkForce true;
  sys-systemd.enable = lib.mkDefault true;

  system.stateVersion = "24.05";
}

