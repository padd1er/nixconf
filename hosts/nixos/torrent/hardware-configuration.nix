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
    # kernelParams = [ "amd_pstate=active" "rootdelay=20" ]; # AMD CPU power management
    # boot.kernelParams = [ "usb-storage.quirks=152d:0583:u" ];

    kernelParams = [
      "usb-storage.quirks=152d:0583:u"
      "amd_pstate=active"
      "rootdelay=20"
      "usbcore.autosuspend=-1" # Prevents USB sleep during boot
      "pcie_aspm=off" # Sometimes helps with NVMe-to-USB stability
    ];
    initrd = {
      # kernelModules = [
      #   "nvme"
      #   "uas"
      #   "usb_storage"
      #   "xhci_pci"
      #   "ahci"
      #   "sd_mod"
      #   "vfat"
      #   "nls_cp437"
      #   "nls_iso8859-1"
      # ];

      # Keep these here as a fallback
      # availableKernelModules = [
      #   "usbhid"
      #   "rtsx_pci_sdmmc"
      # ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ohci_pci"
        "ehci_pci"
        "xhci_hcd"
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
    enableAllFirmware = true;

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
