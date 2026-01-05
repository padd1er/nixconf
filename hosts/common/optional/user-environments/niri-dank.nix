{
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
    systemPackages = with pkgs; [
      dgop
    ];
  };

  systemd.user.services = {
    swayidle = {
      description = "Idle Service";
      documentation = "man:swayidle(1)";
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
