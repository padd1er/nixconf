{ pkgs, lib, config, ... }:

{

  options = {
    app-terminal.enable = lib.mkEnableOption "enables app-terminal";
  };

  config = lib.mkIf config.app-terminal.enable {

    environment.systemPackages = with pkgs; [
      alacritty
      wezterm
    ];
  };
}

