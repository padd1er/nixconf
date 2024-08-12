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
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  networking.hostName = "wsl-nixos";

  system.stateVersion = "24.05";
}

