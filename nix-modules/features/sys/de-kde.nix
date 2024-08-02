{ pkgs, lib, config, ... }:

{
  options = {
    sys-de-kde.enable = lib.mkEnableOption "enables sys-de-kde";
  };

  config = lib.mkIf config.sys-de-kde.enable {
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
  };
}

