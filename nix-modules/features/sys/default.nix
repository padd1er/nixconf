{ pkgs
, lib
, config
, ...
}:

{
  imports =
    [
      ./main-user.nix
      ./nixos.nix
      ./system.nix
      ./systemd.nix
    ];

  sys-nixos.enable = lib.mkDefault false;
  sys-system.enable = lib.mkDefault false;
  sys-systemd.enable = lib.mkDefault false;
  sys-main-user.enable = lib.mkDefault false;
}


