{ pkgs, lib, config, ... }:

{
  options = {
    sys-de-cosmic.enable = lib.mkEnableOption "enables sys-de-cosmic";
  };

  config = lib.mkIf config.sys-de-cosmic.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
      # xserver = {
      #   enable = true;
      # };
    };
  };
}

