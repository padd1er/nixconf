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
    blacklistedKernelModules = [ "nouveau" ];
    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];

    kernelParams = [
      "module_blacklist=amdgpu"
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

  fileSystems = {
    "/mnt/win/games" = {
      device = "/dev/disk/by-uuid/0AAAB747AAB72E57";
      fsType = "ntfs-3g";
      options = [
        "rw"
        "uid=1000"
        "gid=100"
        "dmask=022"
        "fmask=133"
        "noatime"
      ];
    };

    "/mnt/win/system" = {
      device = "/dev/disk/by-uuid/80DA962BDA961E0A";
      fsType = "ntfs-3g";
      options = [
        "rw"
        "uid=1000"
        "gid=100"
        "dmask=022"
        "fmask=133"
        "noatime"
      ];
    };

    "/mnt/win/sub-system" = {
      device = "/dev/disk/by-uuid/B834259834255B20";
      fsType = "ntfs-3g";
      options = [
        "rw"
        "uid=1000"
        "gid=100"
        "dmask=022"
        "fmask=133"
      ];
    };

    "/mnt/ugreen-smb/public-upload" = {
      device = "//192.168.1.5/public-upload";
      fsType = "cifs";
      options = [
        "credentials=/run/secrets/rendered/ugreen-smb-user"
        "iocharset=utf8"
        "vers=3.1.1"
        "uid=1000"
        "gid=100"
        "nofail"
        "x-systemd.automount"
        "_netdev"
      ];
    };

    "/mnt/ugreen-smb/kasia" = {
      device = "//192.168.1.5/kasia";
      fsType = "cifs";
      options = [
        "credentials=/run/secrets/rendered/ugreen-smb-user"
        "iocharset=utf8"
        "vers=3.1.1"
        "uid=1000"
        "gid=100"
        "nofail"
        "x-systemd.automount"
        "_netdev"
      ];
    };

    "/mnt/ugreen-smb/moved-from-pc" = {
      device = "//192.168.1.5/moved-from-pc";
      fsType = "cifs";
      options = [
        "credentials=/run/secrets/rendered/ugreen-smb-user"
        "iocharset=utf8"
        "vers=3.1.1"
        "uid=1000"
        "gid=100"
        "nofail"
        "x-systemd.automount"
        "_netdev"
      ];
    };

    "/mnt/ugreen-smb/backup-torrent" = {
      device = "//192.168.1.5/backup-torrent";
      fsType = "cifs";
      options = [
        "credentials=/run/secrets/rendered/ugreen-smb-user"
        "iocharset=utf8"
        "vers=3.1.1"
        "uid=1000"
        "gid=100"
        "nofail"
        "x-systemd.automount"
        "_netdev"
      ];
    };

    "/mnt/ugreen-smb/backup-flashdrive" = {
      device = "//192.168.1.5/backup-flashdrive";
      fsType = "cifs";
      options = [
        "credentials=/run/secrets/rendered/ugreen-smb-user"
        "iocharset=utf8"
        "vers=3.1.1"
        "uid=1000"
        "gid=100"
        "nofail"
        "x-systemd.automount"
        "_netdev"
      ];
    };
  };

  swapDevices = [ ];

  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
    };
    udisks2.enable = true;
  };

  hardware = {
    cpu.amd.updateMicrocode = lib.mkForce true;

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
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
