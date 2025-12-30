{
  pkgs,
  ...
}:

{
  # NOTE: https://nixos.wiki/wiki/Steam
  # NOTE: https://wiki.nixos.org/wiki/Lutris
  # NOTE: https://wiki.nixos.org/wiki/Heroic_Games_Launcher

  environment.systemPackages = with pkgs; [
    steam
    steam-run
    steam-devices-udev-rules
    protonup-qt
    protontricks
    lutris
    heroic
    gogdl
    mangohud
    goverlay
    gamescope
    gamemode
    wineWowPackages.stable
    winetricks
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    gamescope = {
      enable = true;
    };

    gamemode = {
      enable = true;
    };
  };
}
