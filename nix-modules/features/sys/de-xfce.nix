{ pkgs, lib, config, ... }:

{
  options = {
    sys-de-xfce.enable = lib.mkEnableOption "enables sys-de-xfce";
  };

  config = lib.mkIf config.sys-de-xfce.enable {
    services.xserver = {
      enable = true;
      desktopManager = {
        xfce.enable = true;
      };
    };
    services.displayManager.defaultSession = "xfce";
  };
}

