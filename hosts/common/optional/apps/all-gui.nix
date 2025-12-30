{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    amberol
    bibata-cursors
    bitwarden-desktop
    # firefox
    ghostty
    google-chrome
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    keepassxc
    localsend
    mpv
    nomacs
    obs-studio
    papirus-icon-theme
    # rustdesk
    rustdesk-flutter
    seafile-client
    slack
    spotify
    telegram-desktop
  ];
}
