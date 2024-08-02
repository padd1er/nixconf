{ pkgs, lib, config, ... }:

{

  options = {
    sys-network.enable = lib.mkEnableOption "enables sys-network";
  };

  config = lib.mkIf config.sys-network.enable {
    networking.networkmanager.enable = true;
    networking.enableIPv6 = false;
    networking.firewall.enable = false;
  };
}
