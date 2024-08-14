{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ../features/sys/default.nix
    ../features/app/default.nix
    ../features/service/default.nix
  ];

  # battery
  services.upower.enable = true;

  security.polkit.enable = true;
}
