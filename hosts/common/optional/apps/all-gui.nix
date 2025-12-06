{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # alacritty
    amberol
    bibata-cursors
    bitwarden-desktop
    # firefox
    # flameshot
    # gradia
    # shutter
    ghostty
    google-chrome
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    # keepassxc
    localsend
    mpv
    nomacs
    obs-studio
    papirus-icon-theme
    rustdesk-flutter # NOTE: this is instead lf default rustdesk which is at 1.2.3 version and fails to build due to rust 1.80.0 https://github.com/NixOS/nixpkgs/issues/332957
    # NOTE: this is due to qtwebengine5-15 EOL/deprecation
    inputs.nixpkgs-stable.legacyPackages."${pkgs.stdenv.hostPlatform.system}".seafile-client
    # seafile-client
    slack
    spotify
    telegram-desktop
  ];

  # catppuccin.flavor = "mocha";
  # catppuccin.enable = true;
}
