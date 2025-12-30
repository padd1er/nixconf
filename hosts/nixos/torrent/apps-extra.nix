{
  pkgs,
  ...
}:

{

  imports = [
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
    coolercontrol.coolercontrol-gui
    coolercontrol.coolercontrold
    coolercontrol.coolercontrol-ui-data
    lm_sensors
    # nvidia stuff
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    # gaming
    mangohud
    gamemode
    wineWowPackages.stable
    winetricks
    protontricks
    # anker camera
    cameractrls
    cameractrls-gtk4
    # portals
    xdg-desktop-portal-wlr
    # devenv
    distrobox
    distrobox-tui
    podman
    podman-compose
    podman-tui
    podman-desktop
    winboat
    # samba
    samba
    cifs-utils
  ];
  programs.coolercontrol.enable = true;
}
