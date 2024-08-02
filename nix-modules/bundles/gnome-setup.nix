{ pkgs, lib, config, ... }:

{
  imports =
    [
      ./general-setup.nix
      ../features/app/default-gui.nix
    ];

  sys-de-gnome.enable = true;
}
