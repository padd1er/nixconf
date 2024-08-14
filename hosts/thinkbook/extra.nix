{
  config,
  lib,
  pkgs,
  ...
}:

{

  imports = [
    # and this below are custom
    ../../nix-modules/bundles/setup-xfce.nix
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

}
