{
  lib,
  options,
  ...
}:
{
  # TODO: remove when systemd is in stable
  config = lib.optionalAttrs (options ? systemd.settings) {
    systemd.settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };
  };
}
