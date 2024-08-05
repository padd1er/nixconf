{ config
, lib
, pkgs
, ...
}:

{

  imports = [
    # and this below are custom
    ../../nix-modules/bundles/setup-xfce.nix
  ];

  environment.systemPackages = [
    #   pkgs.nix-ld-rs
    #   pkgs.nix-diff
    #   pkgs.nix-index
    #   pkgs.nix-health
  ];

}


