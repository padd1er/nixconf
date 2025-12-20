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

    kernelParams = [
      # "usb-storage.quirks=152d:0583:u" # nvme
      "amd_pstate=active"
      "rootdelay=20"
      "usbcore.autosuspend=-1" # NOTE: this prevents usb sleep during boot
      "pcie_aspm=off" # NOTE: this sometimes helps with nvme-to-usb stability
    ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ohci_pci"
        "ehci_pci"
        "xhci_hcd"
        "ahci"
        "uas"
        "usbhid"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];

      kernelModules = [
        "usb_storage" # NOTE: this is to boot from external usb
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
          "crypted0" = lib.mkForce {
            device = "/dev/disk/by-partuuid/53f7bb6c-7206-41dc-b6b4-8edec7f7637b";
            yubikey = {
              slot = 2;
              twoFactor = false;
              gracePeriod = 3;
              storage = {
                device = "/dev/disk/by-partuuid/5c77d9ce-02bf-4624-a84e-4f1a42e5a792";
                path = "/crypt-storage/torrent";
              };
            };
          };
        };
      };
    };

    loader = {
      efi = {
        canTouchEfiVariables = false; # NOTE: nix is on external drive
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
      open = false;
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
