{ pkgs, lib, config, ... }:

{
  imports =
    [
      ./terminal.nix
    ];


  app-terminal.enable = lib.mkDefault true;
}
