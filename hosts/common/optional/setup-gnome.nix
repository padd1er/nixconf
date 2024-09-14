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
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # desktopManager = {
    #   xfce.enable = true;
    # };
  };
  services.displayManager.defaultSession = "gnome";

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-tour
      gnome-connections
      epiphany
      geary
      evince
    ]
  );

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        # lockAll = true; # prevents overriding
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            clock-show-weekday = true;
          };
        };
      }
    ];
  };
}
