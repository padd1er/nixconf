{ pkgs
, lib
, config
, inputs
, ...
}:

let
  cfg = config.sys-main-user;

  homeDir = "/home/${cfg.username}";
  secretsFile = ../../../secrets.yaml;
in
{
  imports = [
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


    system.activationScripts.cloneRepo = {
      text = ''
                secretsFile='"${secretsFile}"'
                homeDir='"${homeDir}"'
        	token=$(SOPS_AGE_KEY_FILE=/tmp/nix-age.txt ${pkgs.sops}/bin/sops --decrypt --extract "['gitlab_token']" ${secretsFile})
        	user=$(SOPS_AGE_KEY_FILE=/tmp/nix-age.txt ${pkgs.sops}/bin/sops --decrypt --extract "['gitlab_user']" ${secretsFile})
                if [ ! -d ${homeDir}/.dotfiles ]; then
                  # Clone the repository
                  runuser -l ${cfg.username} -c "git clone https://$user:$token@gitlab.com/padd1er_linux/dotfiles.git ${homeDir}/.dotfiles"

                  # Add the submodule section to the .git/config file
                  runuser -l ${cfg.username} -c "git -C ${homeDir}/.dotfiles config --add submodule.stow/nvim/.config/nvim.url https://$user:$token@gitlab.com/padd1er_linux/config-neovim.git"

                  # Initialize and update the submodule
                  runuser -l ${cfg.username} -c "git -C ${homeDir}/.dotfiles submodule update --init --recursive"

                  # Stow dotfiles
                  runuser -l ${cfg.username} -c "cd ${homeDir}/.dotfiles && make stowall"

                  # Post commands
                  runuser -l ${cfg.username} -c "bat cache --build"
                fi
      '';
    };
  };
}
