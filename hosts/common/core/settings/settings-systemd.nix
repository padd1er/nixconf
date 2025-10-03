{
  lib,
  options,
  ...
}:

{
  # TODO: remove "if" when systemd.settings will go stable
  config = lib.mkIf (options ? systemd.settings) {
    systemd.settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };
  };
}
