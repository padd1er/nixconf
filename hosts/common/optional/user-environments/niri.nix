{
  lib,
  inputs,
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
      # WLR_NO_HARDWARE_CURSORS = "1";
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
      # swaylock # NOTE: using quickshell noctalia
      # mako # NOTE: using quickshell noctalia
      kanshi
      libnotify
      swayidle
      xwayland-satellite
      kdePackages.polkit-kde-agent-1
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal-wlr
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  hardware = {
    graphics.enable = true;
  };

  systemd.user.services = {

    polkit-authentication-agent = {
      description = "Polkit Authentication Agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };

    swayidle = {
      description = "Idle Service";
      path = with pkgs; [
        swayidle
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        niri
      ];
      serviceConfig = {
        ExecStart = ''
          ${pkgs.swayidle}/bin/swayidle -w \
            timeout 600 '${
              inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
            }/bin/noctalia-shell ipc call lockScreen lock' \
            timeout 900 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
            timeout 1800 'systemctl suspend'
            before-sleep '${
              inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
            }/bin/noctalia-shell ipc call lockScreen lock'
        '';
        Restart = "on-failure";
      };
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
    };
  };

  services = {
    displayManager.sessionPackages = [ pkgs.niri ];

    power-profiles-daemon.enable = true;

    gnome = {
      gcr-ssh-agent.enable = false;
      gnome-keyring.enable = false;
    };

    # greetd = {
    #   enable = true;
    #   settings = {
    #     terminal = {
    #       vt = lib.mkForce 7;
    #     };
    #     default_session = {
    #       command = ''
    #         ${pkgs.tuigreet}/bin/tuigreet \
    #           --time \
    #           --asterisks \
    #           --debug /tmp/tuigreet.log
    #       '';
    #       user = "greeter";
    #     };
    #   };
    # };
  };
}
