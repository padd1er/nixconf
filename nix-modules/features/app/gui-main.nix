{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{

  options = {
    app-gui-main.enable = lib.mkEnableOption "enables app-gui-main";
  };

  config = lib.mkIf config.app-gui-main.enable {
    environment.systemPackages = with pkgs; [
      inputs.wezterm.packages.${pkgs.system}.default
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
    ];
  };
}
