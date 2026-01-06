{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./greetd.nix
    ./niri.nix
    inputs.noctalia.nixosModules.default
  ];

  environment = {
    systemPackages = with pkgs; [
      kdePackages.polkit-kde-agent-1
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  services.noctalia-shell.enable = true;

  systemd.user.services = {

    polkit-authentication-agent = {
      description = "Polkit Authentication Agent";
      path = with pkgs; [
        kdePackages.polkit-kde-agent-1
      ];
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
        niri
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      serviceConfig = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.swayidle}/bin/swayidle -w \
            timeout 600 '${
              inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
            }/bin/noctalia-shell ipc call lockScreen lock' \
            timeout 900 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
              resume '${pkgs.niri}/bin/niri msg action power-on-monitors' \
            timeout 1800 'systemctl suspend' \
            before-sleep '${
              inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
            }/bin/noctalia-shell ipc call lockScreen lock'
        '';
        Restart = "on-failure";
      };
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
    };

  };
}
