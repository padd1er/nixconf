{
  config,
  lib,
  libCustom,
  nixos-raspberrypi,
  ...
}:

{
  # NOTE: argone is broken! add it maybe somehow
  # TODO: review hardware configs

  imports = lib.flatten [
    ./hardware-configuration.nix
    ./apps-extra.nix
    (map libCustom.relativeToRoot [
      "modules/common/host-spec.nix"
      "hosts/common/core"
      "hosts/common/optional/settings/settings-ssh.nix"
      "hosts/common/users/primary"
    ])
    nixos-raspberrypi.nixosModules.nixpkgs-rpi
  ];

  hostSpec = {
    name = "box";
    primaryUser = {
      name = "padd1er";
      enableDotfiles = true;
      setPassword = true;
    };
  };

  networking.hostName = "${config.hostSpec.name}-nixos";

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "25.05";
}
