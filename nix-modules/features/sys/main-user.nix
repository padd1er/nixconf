{ pkgs
, lib
, config
, inputs
, ...
}:
let
  cfg = config.sys-main-user;

  homeDir = "/home/${cfg.username}";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  options.sys-main-user = {
    enable = lib.mkEnableOption "enable main-user module";

    username = lib.mkOption {
      default = "username";
      description = ''
        username
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    users.users.${cfg.username} = {
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "wheel" "networkmanager" "sudo" "audio" "video" "input" "docker" ];
      shell = pkgs.fish;
    };

    sops.defaultSopsFile = ../../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = ../../../keys.txt;

    system.activationScripts.cloneRepo = {
      text = ''
        $(cat ${config.sops.secrets.top_secret.path})
        homeDir='"${homeDir}"'
        if [ ! -d /home/${cfg.username}/nixconf ]; then
          runuser -l ${cfg.username} -c "git clone https://github.com/padd1er/nixconf.git ${homeDir}/nixconf"
        fi
      '';
    };
  };
}
