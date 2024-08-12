{ pkgs
, lib
, config
, inputs
, ...
}:

{

  options = {
    app-gui-main.enable = lib.mkEnableOption "enables app-gui-main";
  };

  config = lib.mkIf config.app-gui-main.enable {
    environment.systemPackages = with pkgs; [
      inputs.wezterm.packages.${pkgs.system}.default
      firefox
      google-chrome
      alacritty
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

