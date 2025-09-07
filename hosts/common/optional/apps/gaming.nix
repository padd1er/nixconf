{
  pkgs,
  ...
}:

{
  # NOTE: https://nixos.wiki/wiki/Steam
  # NOTE: https://wiki.nixos.org/wiki/Lutris
  # https://wiki.nixos.org/wiki/Heroic_Games_Launcher

  environment.systemPackages = with pkgs; [
    steam
    # steam-original
    steam-unwrapped
    steam-run
    steam-devices-udev-rules
    protonup-qt
    heroic
    heroic-unwrapped
    gogdl
    lutris
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
