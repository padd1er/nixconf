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
      # path = with pkgs; [
      #   swayidle
      #   niri
      #   inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default
      # ];
      # TODO: this is temp due to dms naming /nix/store/dq46w55g0wqyrrvgvh8vi286d2458dil-dms-shell-1.2-unstable+date=2026-01-10_c60cd3a
      path = lib.mkForce [ ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.swayidle}/bin/swayidle -w timeout 600 'dms ipc call lock lock' timeout 900 'niri msg action power-off-monitors' resume 'niri msg power-on-monitors' timeout 1800 'systemctl suspend' before-sleep 'dms ipc call lock lock'";
        Restart = "on-failure";
      };
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
    };
  };
}
