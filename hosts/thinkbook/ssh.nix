{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  sysMainUserModule = ../../nix-modules/features/sys/main-user.nix;
  sysMainUser = import sysMainUserModule {
    inherit
      pkgs
      lib
      config
      inputs
      ;
  };

  userName = config.sys-main-user.username;
  homeDir = "/home/${userName}";
  secretsFile = ../../secrets.yaml;
  keyFile = "${homeDir}/.ssh/${userName}_at_thinkbook";
in
{
  imports = [ sysMainUserModule ];
  system.activationScripts.setupKey = {
    text = ''
          userName='"${userName}"'
          secretsFile='"${secretsFile}"'
          homeDir='"${homeDir}"'
          keyFile='"${keyFile}"'
          key=$(SOPS_AGE_KEY_FILE=/tmp/nix-age.txt ${pkgs.sops}/bin/sops --decrypt --extract "['thinkbook_key']" ${secretsFile})
      if [ ! -d ${homeDir}/.ssh ]; then
        runuser -l ${userName} -c "mkdir -p ${homeDir}/.ssh"
      fi
      runuser -l ${userName} -c "echo \"$key\" > ${keyFile}"
      runuser -l ${userName} -c "chmod 600 ${keyFile}"
    '';
  };
}
