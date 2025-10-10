{
  inputs,
  config,
  lib,
  libCustom,
  ...
}:

{

  # TODO: add hardware for amd
  # TODO: review hardware options
  # TODO: tweak for minimal steam gaming
  # TODO: setup hyprland environment
  # TODO: setup kde environment
  imports = lib.flatten [
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko.nix
    ./apps-extra.nix
    (map libCustom.relativeToRoot [
      "modules/common/host-spec.nix"
      "hosts/common/core"
      "hosts/common/users/primary"
      "hosts/common/optional/settings/settings-ssh.nix"
      "hosts/common/optional/settings/settings-bluetooth.nix"
      "hosts/common/optional/settings/settings-sound.nix"
      "hosts/common/optional/settings/settings-cups-printer.nix"
      "hosts/common/optional/settings/settings-yubikey-lock.nix"
      "hosts/common/optional/apps/all-cli.nix"
      "hosts/common/optional/apps/all-gui.nix"
      "hosts/common/optional/apps/qmk.nix"
      "hosts/common/optional/apps/gaming.nix"
      "hosts/common/optional/apps/libreoffice.nix"
      "hosts/common/optional/apps/wezterm-flake.nix"
      "hosts/common/optional/apps/piper-tts-overlay.nix"
      "hosts/common/optional/apps/yubikey.nix"
      "hosts/common/optional/user-environments/xfce.nix"
    ])
  ];

  hostSpec = {
    name = "thinkbook";
    primaryUser = {
      name = "padd1er";
      enableDotfiles = true;
      setPassword = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.fido2Support = false;

  networking.hostName = "${config.hostSpec.name}-nixos";

  services.libinput.enable = true;

  system.stateVersion = "24.05";
}
