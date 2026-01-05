{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./greetd.nix
    ./niri.nix
  ];

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

  environment = {
    variables = {
      QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3";
    };

    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    systemPackages = with pkgs; [
      dgop
      i2c-tools
    ];
  };

  systemd.user.services = {
    dms = {
      description = "DankMaterialShell";
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      restartIfChanged = true;
      serviceConfig = {
        # ExecStart = "dms run --session";
        ExecStart = "dms run --session --config %h/.config/DankMaterialShell/torrent/";
        Restart = "on-failure";
      };
    };

    swayidle = {
      description = "Idle Service";
      path = with pkgs; [
        swayidle
        niri
      ];
      serviceConfig = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.swayidle}/bin/swayidle -w \
            timeout 600 'dms ipc call lock lock' \
            timeout 900 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
              resume '${pkgs.niri}/bin/niri msg action power-on-monitors' \
            timeout 1800 'systemctl suspend' \
            before-sleep 'dms ipc call lock lock'
        '';
        Restart = "on-failure";
      };
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
    };
  };
}
