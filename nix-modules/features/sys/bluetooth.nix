{ pkgs, lib, config, ... }:

{
  options = {
    sys-bluetooth.enable = lib.mkEnableOption "enables sys-bluetooth";
  };

  config = lib.mkIf config.sys-bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
