{
  disko.devices = {
    disk = {
      my-disk = {
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            swap = {
              size = "4G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            home = {
              size = "20G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
              };
            };

            root = {
              size = "100%";
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
  };
}
