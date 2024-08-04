{ pkgs, lib, config, ... }:

{
  imports =
    [
      ./gui-main.nix
    ];


  app-gui-main.enable = lib.mkDefault true;
}
