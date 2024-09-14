{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [ ./default.nix ];

  app-cli-other.enable = lib.mkForce true;
  app-gui-main.enable = lib.mkForce true;

  services = {
    xserver = {
      enable = true;
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
  ];
}
