{
  disko.devices = {
    disk = {
      disk0 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };

            };
            root = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted-root";
                settings.allowDiscards = true;
                passwordFile = "/tmp/nix-root.key";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };

      disk1 = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            home = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted-home";
                settings.allowDiscards = true;
                passwordFile = "/tmp/nix-home.key";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/home";
                };
              };
            };
          };
        };
      };
    };
  };
}
