{
  config,
  inputs,
  lib,
  libCustom,
  pkgs,
  ...
}:

{
  # TODO: gnome or kde
  # NOTE: gnome https://wiki.nixos.org/wiki/GNOME
  imports = lib.flatten [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    ./disko.nix
    (map libCustom.relativeToRoot [
      "modules/common/host-spec.nix"
      "hosts/common/core"
      "hosts/common/optional/settings/settings-ssh.nix"
      "hosts/common/optional/settings/settings-bluetooth.nix"
      "hosts/common/optional/settings/settings-sound.nix"
      "hosts/common/optional/settings/settings-cups-printer.nix"
      "hosts/common/optional/apps/all-gui.nix"
      "hosts/common/optional/apps/libreoffice.nix"
      "hosts/common/optional/user-environments/gnome.nix"
      "hosts/common/users/primary"
    ])
  ];

  hostSpec = {
    name = "ideapad";
    primaryUser = {
      name = "graj";
      enableDotfiles = true;
      setPassword = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "${config.hostSpec.name}-nixos";

  services.libinput.enable = true;

  # TODO: this is optional, remove later
  environment.systemPackages = with pkgs; [
    teams-for-linux
    whatsapp-for-linux
    zoom-us
  ];

  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "24.11";
}
