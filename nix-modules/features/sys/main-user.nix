{ pkgs, lib, config, ... }:
let
  cfg = config.sys-main-user;
in
{
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

    system.activationScripts.cloneRepo = {
      text = ''
        if [ ! -d /home/${cfg.username}/nixconf ]; then
          sudo -u ${cfg.username} git clone https://github.com/padd1er/nixconf.git /home/${cfg.username}/nixconf
        fi
      '';
    };
  };
}
