{
  pkgs,
  ...
}:

{

  imports = [
  ];

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    jujutsu
    claude-code
    # audio tools
    sox
    alsa-utils
    pulseaudio
    wireplumber
  ];
}
