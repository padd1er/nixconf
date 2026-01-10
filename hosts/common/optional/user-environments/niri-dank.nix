{
  inputs,
  config,
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
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      quickshell.package = pkgs.quickshell;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      enableDynamicTheming = false;
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
    ];
  };

  systemd.user.services = {
    swayidle = {
      description = "Idle Service";
      path = with pkgs; [
        dms-shell
        swayidle
        niri
      ];
      serviceConfig = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.swayidle}/bin/swayidle -w \
            timeout 600 '${
              inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default
            }/bin/dms ipc call lock lock' \
            timeout 900 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
              resume '${pkgs.niri}/bin/niri msg action power-on-monitors' \
            timeout 1800 'systemctl suspend' \
            before-sleep '${
              inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default
            }/bin/dms ipc call lock lock'
        '';
        Restart = "on-failure";
      };
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
    };
  };
}
