{ pkgs
, lib
, config
, ...
}:

{
  options = {
    sys-systemd.enable = lib.mkEnableOption "enables sys-systemd";
  };

  config = lib.mkIf config.sys-systemd.enable {
    systemd = {
      extraConfig = ''
        DefaultTimeoutStopSec=10s
      '';
      user.extraConfig = ''
        DefaultTimeoutStopSec=10s

      '';
    };
  };
}
