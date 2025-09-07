# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  inputs,
  config,
  lib,
  libCustom,
  ...
}:

{

  imports = lib.flatten [
    inputs.nixos-wsl.nixosModules.default
    (map libCustom.relativeToRoot [
      "modules/common/host-spec.nix"
      "hosts/common/core"
      "hosts/common/optional/settings/settings-ssh.nix"
      "hosts/common/users/primary"
      "hosts/common/optional/apps/all-cli.nix"
    ])
  ];

  hostSpec = {
    name = "wsl";
    primaryUser = {
      name = "skarbie";
      enableDotfiles = true;
    };
  };

  wsl = {
    enable = true;
    defaultUser = config.hostSpec.primaryUser.name;
    interop = {
      register = true;
    };
  };

  networking.hostName = "${config.hostSpec.name}-nixos";

  system.stateVersion = "24.05";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
