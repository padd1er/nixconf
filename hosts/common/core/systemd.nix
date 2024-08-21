{
  config,
  lib,
  pkgs,
  ...
}:

{
  systemd = {
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
    user.extraConfig = ''
      DefaultTimeoutStopSec=10s

    '';
  };
}
