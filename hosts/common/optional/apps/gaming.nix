{
  inputs,
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
    gamescope-wsi
    # TODO: think about it
    # gamemode
    wineWowPackages.stable
    winetricks
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    inputs.scopebuddy.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    gamescope = {
      enable = true;
      # capSysNice = true;
    };

    # gamemode = {
    #   enable = true;
    # };
  };
}
