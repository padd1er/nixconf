{ pkgs, lib, config, ... }:

{
  options = {
    sys-wm-hyprland.enable = lib.mkEnableOption "enables sys-wm-hyprland";
  };

  config = lib.mkIf config.sys-wm-hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      # WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    hardware = {
      graphics.enable = true;
    };

    environment.systemPackages = with pkgs; [
      waybar
      # mako
      dunst
      libnotify
      hyprpaper
      kitty
      rofi-wayland
      wl-clipboard
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd hyprland";
          user = "greeter";
        };
      };
    };
  };
}


