{ pkgs, lib, config, ... }:

{
  imports =
    [
      ./de-gnome.nix
      ./de-kde.nix
      ./de-xfce.nix
      ./nixos.nix
      ./system.nix
      ./systemd.nix
    ];

  sys-de-gnome.enable = lib.mkDefault false;
  sys-de-kde.enable = lib.mkDefault false;
  sys-de-xfce.enable = lib.mkDefault false;
  sys-nixos.enable = lib.mkDefault true;
  sys-system.enable = lib.mkDefault true;
  sys-systemd.enable = lib.mkDefault true;
}


