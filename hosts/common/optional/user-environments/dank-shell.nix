{
  lib,
  inputs,
  pkgs,
  ...
}:

{
  programs = {
    dms-shell = {
      enable = true;
      systemd = {
        enable = false;
        restartIfChanged = false;
      };
    };

    dsearch = {
      enable = true;
      systemd = {
        enable = true;
        target = "graphical-session.target";
      };
    };
  };

  security = {
    polkit = {
      enable = true;
    };
    # pam.services.swaylock = { }; # NOTE: using quickshell noctalia
  };

  environment = {
    systemPackages = with pkgs; [
      dgop
    ];
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };

  systemd.user.services = {
    # polkit-authentication-agent = {
    #   description = "Polkit Authentication Agent";
    #   wantedBy = [ "graphical-session.target" ];
    #   wants = [ "graphical-session.target" ];
    #   after = [ "graphical-session.target" ];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
    #     Restart = "on-failure";
    #     RestartSec = 1;
    #   };
    # };

    # swayidle = {
    #   description = "Idle Service";
    #   path = with pkgs; [
    #     swayidle
    #     inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    #     niri
    #   ];
    #   serviceConfig = {
    #     ExecStart = ''
    #       ${pkgs.swayidle}/bin/swayidle -w \
    #         timeout 600 '${
    #           inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    #         }/bin/noctalia-shell ipc call lockScreen lock' \
    #         timeout 900 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
    #         resume '${pkgs.niri}/bin/niri msg action power-on-monitors' \
    #         timeout 1800 'systemctl suspend' \
    #         before-sleep '${
    #           inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    #         }/bin/noctalia-shell ipc call lockScreen lock'
    #     '';
    #     Restart = "on-failure";
    #   };
    #   wantedBy = [ "graphical-session.target" ];
    #   after = [ "graphical-session.target" ];
    # };
  };

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #     pkgs.xdg-desktop-portal-gnome
  #     pkgs.xdg-desktop-portal-wlr
  #     # pkgs.kdePackages.xdg-desktop-portal-kde
  #   ];
  #   # config = {
  #   #   common = {
  #   #     default = [ "gtk" ];
  #   #   };
  #   #   niri = {
  #   #     "org.freedesktop.impl.portal.ScreenCast" = [
  #   #       "kde"
  #   #       "wlr"
  #   #       "gnome"
  #   #     ];
  #   #     "org.freedesktop.impl.portal.Screenshot" = [
  #   #       "kde"
  #   #       "wlr"
  #   #       "gnome"
  #   #     ];
  #   #     "org.freedesktop.impl.portal.RemoteDesktop" = [
  #   #       "kde"
  #   #       "wlr"
  #   #       "gnome"
  #   #     ];
  #   #   };
  #   # };
  # };

  # services = {
  #   displayManager.sessionPackages = [ pkgs.niri ];
  #
  #   power-profiles-daemon.enable = true;
  #
  #   gnome = {
  #     gcr-ssh-agent.enable = false;
  #     gnome-keyring.enable = false;
  #   };
  # };
}
