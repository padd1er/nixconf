{
  overlays,
  pkgs,
  ...
}:

{

  imports = [
  ];
  nixpkgs.overlays = [
    overlays.easyeffects
  ];

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    jujutsu
    claude-code
    nmap
    lazyjournal
    # brightness
    brightnessctl
    # coolers and fans
    # coolercontrol.coolercontrol-gui
    # coolercontrol.coolercontrold
    # coolercontrol.coolercontrol-ui-data
    discord
    discord-gamesdk
    discord-rpc
    netflix
    lm_sensors
    # samba
    # samba
    cifs-utils
    # gui file manager
    # xfce.thunar
    # xfce.thunar-volman
    # xfce.thunar-archive-plugin
    # xfce.tumbler
    # gvfs
    nvidia-vaapi-driver
    easyeffects
  ];

  # services = {
  #   gvfs = {
  #     enable = true;
  #   };
  #
  #   tumbler.enable = true;
  #
  #   samba = {
  #     enable = true;
  #     nmbd.enable = true;
  #   };
  #
  # };
  programs = {
    coolercontrol.enable = true;
    #
    # xfconf.enable = true;
    #
    # thunar = {
    #   enable = true;
    #   plugins = with pkgs.xfce; [
    #     thunar-archive-plugin
    #     thunar-volman
    #   ];
    # };
  };
}
