{
  pkgs,
  lib,
  config,
  ...
}:

{
  environment.systemPackages = with pkgs; [ doas ];

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [
            "wheel"
            "sudo"
          ];
          noPass = true;
          keepEnv = true;
        }
      ];
    };
  };
}
