{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  userName = "padd1er";

  homeDir = "/home/${userName}";
  keyFile = "${homeDir}/.ssh/${userName}";
  secretsFile = ../../../../secrets.yaml;
in
{
  # TODO: think about how this can be abstracted to avoid boilerplate
  users.users.${userName} = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "sudo"
      "audio"
      "video"
      "input"
      "docker"
    ];
    shell = pkgs.fish;
  };

  system.userAactivationScripts.cloneRepo = {
    text = ''
      secretsFile='"${secretsFile}"'
      homeDir='"${homeDir}"'
      token=$(SOPS_AGE_KEY_FILE=/tmp/nix-age.txt ${pkgs.sops}/bin/sops --decrypt --extract "['gitlab_token']" ${secretsFile})
      user=$(SOPS_AGE_KEY_FILE=/tmp/nix-age.txt ${pkgs.sops}/bin/sops --decrypt --extract "['gitlab_user']" ${secretsFile})
      if [ ! -d ${homeDir}/.dotfiles ]; then
        # Clone the repository
        runuser -l ${userName} -c "git clone https://$user:$token@gitlab.com/padd1er_linux/dotfiles.git ${homeDir}/.dotfiles"

        # Add the submodule section to the .git/config file
        runuser -l ${userName} -c "git -C ${homeDir}/.dotfiles config --add submodule.stow/nvim/.config/nvim.url https://$user:$token@gitlab.com/padd1er_linux/config-neovim.git"

        # Initialize and update the submodule
        runuser -l ${userName} -c "git -C ${homeDir}/.dotfiles submodule update --init --recursive"

        # Stow dotfiles
        runuser -l ${userName} -c "cd ${homeDir}/.dotfiles && make stowall"

        # Post commands
        runuser -l ${userName} -c "bat cache --build"
      fi
    '';
  };

  system.userAactivationScripts.setSshKey = {
    text = ''
      userName='"${userName}"'
      secretsFile='"${secretsFile}"'
      homeDir='"${homeDir}"'
      keyFile='"${keyFile}"'
      key=$(SOPS_AGE_KEY_FILE=/tmp/nix-age.txt ${pkgs.sops}/bin/sops --decrypt --extract "['padd1er_key']" ${secretsFile})
      if [ ! -d ${homeDir}/.ssh ]; then
        runuser -l ${userName} -c "mkdir -p ${homeDir}/.ssh"
      fi
      runuser -l ${userName} -c "echo \"$key\" > ${keyFile}"
      runuser -l ${userName} -c "chmod 600 ${keyFile}"
    '';
  };
}
