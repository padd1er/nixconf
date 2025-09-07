{
  lib,
  ...
}:

{
  options.hostSpec = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the machine.";
    };

    primaryUser = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "The username of the primary user on this host.";
      };

      enableDotfiles = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable dotfiles setup for this primary user.";
      };

      setPassword = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable password setup for this primary user.";
      };
    };
  };

  config = { };
}
