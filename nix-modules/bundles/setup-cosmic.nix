{ pkgs
, lib
, config
, ...
}:

{
  imports =
    [
      ./default.nix
    ];

  app-cli-other.enable = lib.mkForce true;
  app-gui-main.enable = lib.mkForce true;

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    # xserver = {
    #   enable = true;
    # };
  };
}

