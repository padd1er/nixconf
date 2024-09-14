{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  imports = [
    ./default.nix
    inputs.nixos-cosmic.nixosModules.default
  ];

  app-cli-other.enable = lib.mkForce true;
  app-gui-main.enable = lib.mkForce true;

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };
}
