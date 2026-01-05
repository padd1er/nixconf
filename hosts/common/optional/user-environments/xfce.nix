{
  pkgs,
  ...
}:

{
  import = [
    ./greetd.nix
  ];

  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xfce.enable = true;
      };
      displayManager.lightdm.enable = false;
    };

    # NOTE: this is not necessary
    displayManager.defaultSession = "xfce";
  };

  environment.systemPackages = with pkgs; [
    xorg.xinit
  ];

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     terminal = {
  #       vt = lib.mkForce 7;
  #     };
  #     default_session = {
  #       command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --debug /var/log/tuigreet.log";
  #       user = "greeter";
  #     };
  #   };
  # };
}
