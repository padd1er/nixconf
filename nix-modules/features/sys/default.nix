{ pkgs, lib, config, ... }:

{
  imports =
    [
      ./bluetooth.nix
      ./cups.nix
      ./de-gnome.nix
      ./de-kde.nix
      ./de-xfce.nix
      ./fonts.nix
      ./locale.nix
      ./network.nix
      ./nixos-cleanup.nix
      ./sound.nix
      ./systemd.nix
    ];

  sys-bluetooth.enable = lib.mkDefault true;
  sys-cups.enable = lib.mkDefault true;
  sys-de-gnome.enable = lib.mkDefault false;
  sys-de-kde.enable = lib.mkDefault false;
  sys-de-xfce.enable = lib.mkDefault false;
  sys-fonts.enable = lib.mkDefault true;
  sys-locale.enable = lib.mkDefault true;
  sys-network.enable = lib.mkDefault true;
  sys-nixos-cleanup.enable = lib.mkDefault true;
  sys-sound.enable = lib.mkDefault true;
  sys-systemd.enable = lib.mkDefault true;
}


