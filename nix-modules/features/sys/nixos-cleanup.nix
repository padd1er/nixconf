{ pkgs, lib, config, ... }:

{

  options = {
    sys-nixos-cleanup.enable = lib.mkEnableOption "enables sys-nixos-cleanup";
  };

  config = lib.mkIf config.sys-nixos-cleanup.enable {
    nix.settings.auto-optimise-store = true;
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 3d";
  };
}
