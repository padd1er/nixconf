{ config, lib, pkgs, ... }:

{

  imports = [
    # ../../nix-modules/bundles/xfce-setup.nix
    # ../../nix-modules/bundles/gnome-setup.nix
    # ../../nix-modules/bundles/kde-setup.nix
    # and this below are custom
    ../../nix-modules/bundles/general-setup.nix
    ../../nix-modules/features/app/default-gui.nix
    # ../../nix-modules/features/sys/de-cosmic.nix
    ../../nix-modules/features/sys/wm-hyprland.nix
  ];

  # sys-de-cosmic.enable = true;
  sys-wm-hyprland.enable = true;

  # environment.systemPackages = [
  #   pkgs.nix-ld-rs
  #   pkgs.nix-diff
  #   pkgs.nix-index
  #   pkgs.nix-health
  # ];

}


