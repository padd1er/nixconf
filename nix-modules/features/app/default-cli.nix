{ pkgs, lib, config, ... }:

{
  imports =
    [
      ./doas.nix
      ./cli-main.nix
      ./cli-other.nix
    ];


  app-doas.enable = lib.mkDefault true;
  app-cli-main.enable = lib.mkDefault true;
  app-cli-other.enable = lib.mkDefault false;
}
