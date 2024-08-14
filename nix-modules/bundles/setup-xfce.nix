{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [ ./default.nix ];

  app-cli-other.enable = lib.mkForce true;
  app-gui-main.enable = lib.mkForce true;

  services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = true;
    };
  };
  services.displayManager.defaultSession = "xfce";

}
