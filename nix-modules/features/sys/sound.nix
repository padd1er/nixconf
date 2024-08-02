{ pkgs, lib, config, ... }:

{
  options = {
    sys-sound.enable = lib.mkEnableOption "enables sys-sound";
  };

  config = lib.mkIf config.sys-sound.enable {
    hardware.pulseaudio.enable = lib.mkForce false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
