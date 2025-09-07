{
  pkgs,
  ...
}:

{
  services.desktopManager.gnome.enable = true;

  services.displayManager = {
    defaultSession = "gnome";
    gdm.enable = true;
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      epiphany
      baobab
      evince
      geary
      gnome-connections
      gnome-tour
      orca
      simple-scan
      yelp
      gnome-software
    ]
  );

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    gnome-themes-extra
    gnomeExtensions.appindicator
    gnome-settings-daemon
    sysprof
  ];

  services.dbus.packages = with pkgs; [ gnome2.GConf ];
  services.sysprof.enable = true;

  # TODO: temp error fix, work on later
  services.gnome.gcr-ssh-agent.enable = false;

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
