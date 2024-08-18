{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [ ./default.nix ];

  app-cli-other.enable = lib.mkForce true;
  app-gui-main.enable = lib.mkForce true;

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
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    kdePackages.polkit-kde-agent-1
    # -- bars
    gbar
    waybar
    ironbar
    ags
    # -- notifications
    dunst
    libnotify
    # mako
    # swaync
    # -- applaunchers
    rofi-wayland
    # -- hypr apps
    hyprlock
    hyprpaper
    hypridle
    hyprcursor
    hyprpaper
    # -- other
    kitty
    # -- system utils
    brightnessctl
    wl-clipboard
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  services.greetd = {
    enable = true;
    settings = {
      terminal = {
        vt = 7;
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd hyprland --debug /var/log/tuigreet.log";
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd hyprland --debug /var/log/tuigreet.log --theme border=darkgray;text=white;prompt=lightgray;time=gray;action=cyan;button=lightyellow;container=black;input=lightgray";
        user = "greeter";
      };
    };
  };
}
