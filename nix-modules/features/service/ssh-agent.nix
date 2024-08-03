{ config, pkgs, lib, ... }:

{

  options = {
    service-ssh-agent.enable = lib.mkEnableOption "enables service-ssh-agent";
  };

  config = lib.mkIf config.service-ssh-agent.enable {
    systemd.services.ssh-agent = {
      description = "System-wide SSH Agent";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.openssh}/bin/ssh-agent -a /run/ssh-agent.socket";
        Environment = "SSH_AUTH_SOCK=/run/ssh-agent.socket";
        RemainAfterExit = true;
        ExecStop = "${pkgs.openssh}/bin/ssh-agent -k";
      };
    };

    systemd.user.services.ssh-agent = {
      description = "User-specific SSH Agent";
      after = [ "default.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.openssh}/bin/ssh-agent -a /run/user/%U/ssh-agent.socket";
        Environment = "SSH_AUTH_SOCK=/run/user/%U/ssh-agent.socket";
        RemainAfterExit = true;
        ExecStop = "${pkgs.openssh}/bin/ssh-agent -k";
      };

      wantedBy = [ "default.target" ];
    };

    environment.etc."profile.d/ssh-agent.sh".text = ''
      if [ -z "$SSH_AUTH_SOCK" ]; then
        export SSH_AUTH_SOCK="/run/user/$UID/ssh-agent.socket"
      fi
    '';
  };
}

