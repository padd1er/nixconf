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
  wsl.defaultUser = "skarbie";

  networking.hostName = "wsl-nixos";

  sys-nixos.enable = lib.mkForce true;
  sys-system.enable = lib.mkForce true;

  sys-main-user = {
    enable = true;
    username = "skarbie";
  };

  system.stateVersion = "24.05";
}

