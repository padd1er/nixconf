{
  lib,
  pkgs,
  ...
}:

{

  # TODO: make with dms greeter instead of tuigreet
  services = {
    greetd = {
      enable = true;
      settings = {
        terminal = {
          vt = lib.mkForce 7;
        };
        default_session = {
          command = ''
            ${pkgs.tuigreet}/bin/tuigreet \
              --time \
              --asterisks 
          '';
          #               --debug /tmp/tuigreet.log
          user = "greeter";
        };
      };
    };
  };
}
