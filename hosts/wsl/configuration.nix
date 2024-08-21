# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  system,
  ...
}:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../common/core/default.nix
    ../common/users/skarbie/default.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "skarbie";

  networking.hostName = "wsl-nixos";

  system.stateVersion = "24.05";
}
