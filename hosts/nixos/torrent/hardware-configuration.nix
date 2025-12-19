{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amd_pstate=active" ]; # AMD CPU power management

    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "uas"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [
        "nvme"
        "vfat"
        "nls_cp437"
        "usbhid"
        "nls_iso8859-1"
      ];
      luks = {
        reusePassphrases = false;
        yubikeySupport = true;
        devices = {
          "crypted0" = {
            device = "/dev/disk/by-partlabel/disk-main-luks";
            yubikey = {
              slot = 2;
              twoFactor = false;
              gracePeriod = 3;
              storage = {
                device = "/dev/disk/by-partlabel/disk-main-ESP";
                path = "/crypt-storage/torrent";
              };
            };
          };
        };
      };
    };

    loader = {
      efi = {
        canTouchEfiVariables = false; # External drive
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
      };
    };
  };

  swapDevices = [ ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkForce true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false; # Proprietary driver for gaming
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

}
