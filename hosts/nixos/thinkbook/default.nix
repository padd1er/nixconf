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
  # TODO: setup niri qith quickshell
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
      # "hosts/common/optional/settings/settings-yubikey-lock.nix"
      "hosts/common/optional/settings/settings-ssd.nix"
      "hosts/common/optional/apps/all-cli.nix"
      "hosts/common/optional/apps/all-gui.nix"
      "hosts/common/optional/apps/qmk.nix"
      "hosts/common/optional/apps/gaming.nix"
      "hosts/common/optional/apps/libreoffice.nix"
      "hosts/common/optional/apps/wezterm.nix"
      "hosts/common/optional/apps/piper-tts.nix"
      "hosts/common/optional/apps/yubikey.nix"
      # "hosts/common/optional/user-environments/xfce.nix"
      "hosts/common/optional/user-environments/greetd.nix"
      "hosts/common/optional/user-environments/niri.nix"
      "hosts/common/optional/user-environments/noctalia-shell.nix"
      # "hosts/common/optional/user-environments/hypr.nix"
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

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      luks = {
        reusePassphrases = false;
        yubikeySupport = true;
        devices = {
          "crypted0-root" = {
            device = "/dev/disk/by-partlabel/disk-disk0-root";
            yubikey = {
              slot = 2;
              twoFactor = false;
              gracePeriod = 3;
              storage = {
                device = "/dev/disk/by-partlabel/disk-disk0-boot";
                path = "/crypt-storage/root";
              };
            };
          };
          "crypted1-home" = {
            preLVM = false;
            device = "/dev/disk/by-partlabel/disk-disk1-home";
            yubikey = {
              slot = 2;
              twoFactor = false;
              gracePeriod = 3;
              storage = {
                device = "/dev/disk/by-partlabel/disk-disk0-boot";
                path = "/crypt-storage/home";
              };
            };
          };
        };
      };
    };
  };

  networking.hostName = "${config.hostSpec.name}-nixos";

  services.libinput.enable = true;

  system.stateVersion = "24.05";
}
