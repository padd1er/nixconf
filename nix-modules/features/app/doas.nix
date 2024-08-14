{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    app-doas.enable = lib.mkEnableOption "enables app-doas";
  };

  config = lib.mkIf config.app-doas.enable {

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
  };
}
