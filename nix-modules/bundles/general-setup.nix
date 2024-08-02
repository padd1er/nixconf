{ pkgs, lib, config, ... }:

{
  imports =
    [
      ../features/sys/default.nix
      ../features/app/default-cli.nix
      ../features/service/default.nix
      ../features/sys/main-user.nix
    ];

  # battery
  services.upower.enable = true;

  security.polkit.enable = true;
}
