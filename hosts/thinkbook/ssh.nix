{ pkgs
, lib
, config
, inputs
, ...
}:

let
  sysMainUserModule = ../../nix-modules/features/sys/main-user.nix;
  sysMainUser = import sysMainUserModule { inherit pkgs lib config; };

  userName = sysMainUser.username;
  homeDir = "/home/${userName}";
  secretsFile = ../../secrets.yaml;
in
{
  imports = [
    sysMainUserModule
  ];
  system.activationScripts.setupKey = {
    text = ''
          userName='"${userName}"'
          secretsFile='"${secretsFile}"'
          homeDir='"${homeDir}"'
          key=$(SOPS_AGE_KEY_FILE=/tmp/nix-age.txt ${pkgs.sops}/bin/sops --decrypt --extract "['thinkbook_key']" ${secretsFile})
      if [ ! -d ${homeDir}/.ssh ]; then
        runuser -l ${userName} -c "mkdir -p ${homeDir}/.ssh"
      fi
      runuser -l ${userName} -c "printf '%s\n' \"$key\" > ${homeDir}/.ssh/${userName}_at_thinkbook"
    '';
  };
}
