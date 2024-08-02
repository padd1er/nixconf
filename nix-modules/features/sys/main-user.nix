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
      extraGroups = [ "wheel" "networkmanager" "sudo" "audio" "video" "input" ];
      shell = pkgs.fish;
    };
  };
}
