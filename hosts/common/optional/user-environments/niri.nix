{
  lib,
  pkgs,
  overlays,
  ...
}:

{
  # TODO: work on themes and styling, check with hyprland
  nixpkgs.overlays = [
    overlays.fuzzel-askpass
    overlays.nirius
  ];

  programs = {
    niri.enable = true;
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = true;
          settings = {
            "org/gnome/desktop/interface" = {
              gtk-theme = "catppuccin-mocha-mauve-standard";
              icon-theme = "Tela dracula";
              color-scheme = "prefer-dark";
            };
          };
        }
      ];
    };
    ssh = {
      enableAskPassword = true;
      askPassword = lib.mkForce "${pkgs.fuzzel-askpass}/bin/fuzzel-askpass";
    };
  };

  security = {
    polkit = {
      enable = true;
    };
    # pam.services.swaylock = { }; # NOTE: using quickshell noctalia
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment = {
    pathsToLink = [
      "/share/qt5ct"
      "/share/qt6ct"
    ];

    sessionVariables = {
      SSH_ASKPASS = lib.mkForce "${pkgs.fuzzel-askpass}/bin/fuzzel-askpass";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    systemPackages = with pkgs; [
      grim
      slurp
      satty
      # themes
      (catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "mauve" ];
      })
      catppuccin-qt5ct
      tela-icon-theme
      dconf
      # themes
      cliphist
      wl-clip-persist
      wl-clipboard
      networkmanagerapplet
      fuzzel
      fuzzel-askpass
      nirius # TODO: switch to official package past 0.6.1
      kanshi
      libnotify
      swayidle
      swaylock
      swaybg
      xwayland-satellite
      i2c-tools
    ];
  };

  hardware = {
    graphics.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];
    # config = {
    #   common = {
    #     default = [ "gtk" ];
    #   };
    #   niri = {
    #     "org.freedesktop.impl.portal.ScreenCast" = [
    #       "kde"
    #       "wlr"
    #       "gnome"
    #     ];
    #     "org.freedesktop.impl.portal.Screenshot" = [
    #       "kde"
    #       "wlr"
    #       "gnome"
    #     ];
    #     "org.freedesktop.impl.portal.RemoteDesktop" = [
    #       "kde"
    #       "wlr"
    #       "gnome"
    #     ];
    #   };
    # };
  };

  services = {
    displayManager = {
      sessionPackages = [ pkgs.niri ];
      dms-greeter = {
        compositor.name = "niri";
      };
    };

    power-profiles-daemon.enable = true;

    gnome = {
      gcr-ssh-agent.enable = false;
      gnome-keyring.enable = false;
    };
  };
}
