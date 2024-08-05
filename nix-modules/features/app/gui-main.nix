{ pkgs
, lib
, config
, ...
}:

{

  options = {
    app-gui-main.enable = lib.mkEnableOption "enables app-gui-main";
  };

  config = lib.mkIf config.app-gui-main.enable {
    environment.systemPackages = with pkgs; [
      firefox
      google-chrome
      alacritty
      wezterm
      flameshot
      telegram-desktop
      seafile-client
      bitwarden-desktop
      keepassxc
      slack
      obs-studio
    ];
  };
}

