{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # inputs.wezterm.packages.${pkgs.system}.default
    wezterm
    alacritty
    bitwarden-desktop
    firefox
    flameshot
    google-chrome
    keepassxc
    localsend
    obs-studio
    seafile-client
    slack
    telegram-desktop
    spotify
    rustdesk-flutter # NOTE: this is instead lf default rustdesk which is at 1.2.3 version and fails to build due to rust 1.80.0 https://github.com/NixOS/nixpkgs/issues/332957
    papirus-icon-theme
    bibata-cursors
    mpv
    libreoffice-qt-fresh
    flameshot
    lutris
    protonup-qt
    steam
    heroic
  ];
}
