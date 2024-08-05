{ pkgs
, lib
, config
, ...
}:

{
  imports =
    [
      ./default.nix
    ];

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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd hyprland";
        user = "greeter";
      };
    };
  };
}


