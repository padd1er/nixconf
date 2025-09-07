{
  lib,
  ...
}:

{
  hardware.i2c.enable = true;

  boot.loader.raspberryPi.enable = true;

  hardware.raspberry-pi.config = {
    all = {
      base-dt-params = {
        i2c_arm = {
          enable = true;
          value = "on";
        };
      };
    };
  };

  # TODO: add nvme as /srv
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  fileSystems."/boot/firmware" = {
    device = "systemd-1";
    fsType = "autofs";
  };

  # TODO: add swapfile to /srv
  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
