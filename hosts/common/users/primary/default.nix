{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  userName = config.hostSpec.primaryUser.name;
  hostName = config.hostSpec.name;
  homeDir = "/home/${userName}";
  ownerUser = config.users.users.${userName}.name;
  ownerGroup = config.users.users.${userName}.group;
  authorizedKeys = lib.filesystem.listFilesRecursive ../keys;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  users = {
    mutableUsers = lib.mkIf config.hostSpec.primaryUser.setPassword false;
    users.${userName} = {
      hashedPasswordFile =
        lib.mkIf config.hostSpec.primaryUser.setPassword
          config.sops.secrets."user_passwords/${userName}".path;
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
        "plugdev"
      ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = lib.lists.forEach authorizedKeys (key: builtins.readFile key);
    };
  };

  sops = {
    secrets = {
      "private_keys/${userName}_at_${hostName}" = {
        mode = "0600";
        owner = ownerUser;
        group = ownerGroup;
        path = "${homeDir}/.ssh/id_device";
      };
      "user_passwords/${userName}" = {
        neededForUsers = true;
      };
      "ugreen_smb_passwords/${userName}" = {
        owner = "root";
        mode = "0400";
      };
    };
    templates = {
      "ugreen-smb-user" = {
        content = ''
          username=${userName}
          password=${config.sops.placeholder."ugreen_smb_passwords/${userName}"}
        '';
        owner = "root";
        mode = "0400";
      };
    };
  };

  programs = {
    ssh = {
      startAgent = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d ${homeDir}/.ssh 0700 ${ownerUser} ${ownerGroup} -"
  ];

  # TODO: make it as a systemd service
  # system.activationScripts.dotfiles = lib.mkIf config.hostSpec.primaryUser.enableDotfiles {
  #   text =
  #     let
  #       # List packages needed by this script
  #       scriptPackages = with pkgs; [
  #         git
  #         openssh
  #         gnumake
  #         stow
  #         bat
  #       ];
  #       # Build a path containing the binaries of these packages
  #       scriptPath = lib.makeBinPath scriptPackages;
  #     in
  #     ''
  #       export PATH="${scriptPath}:$PATH"
  #
  #       key_path=${config.sops.secrets."private_keys/nixos_builder".path}
  #       dots_path="${homeDir}/.dotfiles"
  #       SSH_CMD="ssh -i ''${key_path} -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new"
  #       dots_repo="git@gitlab.com:padd1er_linux/dotfiles.git"
  #       nvim_repo="git@gitlab.com:padd1er_linux/config-neovim.git"
  #
  #       set -euo pipefail
  #
  #       if [ ! -d $dots_path ]; then
  #         # Clone the repository
  #         git -c core.sshCommand="$SSH_CMD" clone $dots_repo $dots_path
  #
  #         # Add the submodule section to the .git/config file
  #         git -c core.sshCommand="$SSH_CMD" -C $dots_path config --add submodule.stow/nvim/.config/nvim.url $nvim_repo
  #
  #         # Initialize and update the submodule
  #         git -c core.sshCommand="$SSH_CMD" -C $dots_path submodule update --init --recursive
  #
  #         # Chown
  #         chown -R "${ownerUser}":"${ownerGroup}" $dots_path
  #
  #         # Stow dotfiles
  #         runuser -l ${userName} -c "cd $dots_path && make stowall"
  #
  #         # Post commands
  #         runuser -l ${userName} -c "bat cache --build"
  #       fi
  #     '';
  # };
}
