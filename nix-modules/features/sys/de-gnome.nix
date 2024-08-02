{ pkgs, lib, config, ... }:

{
  options = {
    sys-de-gnome.enable = lib.mkEnableOption "enables sys-de-gnome";
  };

  config = lib.mkIf config.sys-de-gnome.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      # desktopManager = {
      #   xfce.enable = true;
      # };
    };
    services.displayManager.defaultSession = "gnome";

    environment.gnome.excludePackages = (with pkgs; [
      gnome-tour
      gnome-connections
      epiphany
      geary
      evince
    ]);

    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          # lockAll = true; # prevents overriding
          settings = {
            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              clock-show-weekday = true;
            };
          };
        }
      ];
    };
  };
}

