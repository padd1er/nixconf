{
  config,
  lib,
  pkgs,
  ...
}:

{

  imports = [
    # ../../nix-modules/bundles/setup-xfce.nix
    ../../nix-modules/bundles/setup-hypr.nix
  ];

  sys-nixos.enable = lib.mkForce true;
  sys-system.enable = lib.mkForce true;
  sys-systemd.enable = lib.mkForce true;
  sys-main-user.enable = lib.mkForce true;

  environment.systemPackages = [
    #   pkgs.nix-ld-rs
    #   pkgs.nix-diff
    #   pkgs.nix-index
    #   pkgs.nix-health
  ];

  # # Configure keymap in X11
  # # services.xserver.enable = true;
  # services.xserver.xkb.layout = "pl";
  # services.xserver.xkb.variant = "basic";
  # # services.xserver.xkb.model = "pc105";
  # services.xserver.exportConfiguration = true;
  # services.xserver.xkb.options = "lv3:ralt_switch,compose:ralt";
  # programs.dconf.enable = false;
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
}
