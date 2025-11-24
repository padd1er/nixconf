{
  lib,
  inputs,
  pkgs,
  overlays,
  ...
}:

{
  imports = [
    inputs.dankMaterialShell.nixosModules.dankMaterialShell
  ];

  nixpkgs.overlays = [ overlays.fuzzel-askpass ];

  programs = {
    niri.enable = true;
    dconf.enable = true;
    dankMaterialShell.enable = true;
    ssh = {
      enableAskPassword = true;
      askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
      # askPassword = lib.mkForce "${pkgs.fuzzel-askpass}/bin/fuzzel-askpass";
    };
  };

  security = {
    polkit = {
      enable = true;
    };
    pam.services.swaylock = { };
  };

  services.gnome = {
    gcr-ssh-agent.enable = false;
    gnome-keyring.enable = false;
  };

  environment = {
    sessionVariables = {
      SSH_ASKPASS = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
      # SSH_ASKPASS = lib.mkForce "${pkgs.fuzzel-askpass}/bin/fuzzel-askpass";
      # WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [

      rofi
      fuzzel
      fuzzel-askpass
      swaylock
      # mako
      swayidle
      dconf
      xwayland-satellite
      kdePackages.polkit-kde-agent-1
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      kdePackages.ksshaskpass
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  hardware = {
    graphics.enable = true;
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "Polkit KDE Authentication Agent";
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

  services = {
    displayManager.sessionPackages = [ pkgs.niri ];
    greetd = {
      enable = true;
      settings = {
        terminal = {
          vt = lib.mkForce 7;
        };
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --debug /var/log/tuigreet.log";
          user = "greeter";
        };
      };
    };
  };
}
