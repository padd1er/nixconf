{
  inputs,
  pkgs,
  ...
}:

{
  environment = {
    systemPackages = with pkgs; [
      kdePackages.polkit-kde-agent-1
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  # TODO: add noctalia-shell as a service
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
          ${pkgs.swayidle}/bin/swayidle -w -C ~/.config/swayidle/config-niri-noctalia
        '';
        Restart = "on-failure";
      };
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
    };
  };
}
