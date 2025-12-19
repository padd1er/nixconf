{
  inputs,
  config,
  lib,
  pkgs,
  libCustom,
  ...
}:

{
  imports = lib.flatten [
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko.nix
    (map libCustom.relativeToRoot [
      "modules/common/host-spec.nix"
      "hosts/common/core"
      "hosts/common/users/primary"
      # "hosts/common/optional/settings/settings-ssh.nix"
      "hosts/common/optional/settings/settings-bluetooth.nix"
      "hosts/common/optional/settings/settings-sound.nix"
      "hosts/common/optional/settings/settings-cups-printer.nix"
      # # "hosts/common/optional/settings/settings-yubikey-lock.nix"
      "hosts/common/optional/settings/settings-ssd.nix"
      # "hosts/common/optional/apps/all-cli.nix"
      # "hosts/common/optional/apps/all-gui.nix"
      # "hosts/common/optional/apps/qmk.nix"
      # "hosts/common/optional/apps/gaming.nix"
      # "hosts/common/optional/apps/libreoffice.nix"
      # "hosts/common/optional/apps/wezterm-flake.nix"
      # "hosts/common/optional/apps/piper-tts.nix"
      # "hosts/common/optional/apps/yubikey.nix"
      # # "hosts/common/optional/user-environments/xfce.nix"
      # "hosts/common/optional/user-environments/niri.nix"
      # # "hosts/common/optional/user-environments/hypr.nix"
    ])
  ];

  hostSpec = {
    name = "torrent";
    primaryUser = {
      name = "padd1er";
      enableDotfiles = true;
      setPassword = true;
    };
  };

  # +++ common/core/settings/settings-network.nix
  networking.hostName = "${config.hostSpec.name}-nixos";
  # networking.hostName = "torrent-nixos";
  # networking.networkmanager.enable = true;
  # networking.enableIPv6 = false;
  # networking.firewall.enable = false;
  # boot.kernelParams = [ "ipv6.disable=1" ];
  # --- common/core/settings/settings-network.nix

  # +++ common/core/settings/settings-timezone.nix
  # time.timeZone = "Europe/Warsaw";
  # --- common/core/settings/settings-timezone.nix

  # +++ common/core/settings/settings-locale.nix
  # i18n.defaultLocale = "en_US.UTF-8";
  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "pl_PL.UTF-8";
  #   LC_IDENTIFICATION = "pl_PL.UTF-8";
  #   LC_MEASUREMENT = "pl_PL.UTF-8";
  #   LC_MONETARY = "pl_PL.UTF-8";
  #   LC_NAME = "pl_PL.UTF-8";
  #   LC_NUMERIC = "pl_PL.UTF-8";
  #   LC_PAPER = "pl_PL.UTF-8";
  #   LC_TELEPHONE = "pl_PL.UTF-8";
  #   LC_TIME = "en_GB.UTF-8";
  # };
  # --- common/core/settings/settings-locale.nix

  # +++ common/core/settings/settings-font.nix
  # # system font
  # fonts = {
  #   fontDir.enable = true;
  #   packages = with pkgs; [
  #     nerd-fonts.hack
  #     # TODO: review all other below
  #     #  noto-fonts
  #     #  noto-fonts-cjk
  #     #  noto-fonts-emoji
  #     # (nerdfonts.override { fonts = [ "FiraCode" ]; })
  #   ];
  #   fontconfig = {
  #     enable = true;
  #     defaultFonts.monospace = [ "Hack Nerd Font Mono" ];
  #   };
  # };
  #
  # # tty font
  # console = {
  #   earlySetup = true;
  #   packages = [ pkgs.terminus_font ];
  #   font = "ter-v14n";
  #   useXkbConfig = true;
  # };
  #
  # systemd.services.systemd-vconsole-setup.unitConfig.After = "local-fs.target";
  # --- common/core/settings/settings-font.nix

  # +++ common/core/settings/settings-systemd.nix
  # # TODO: remove when systemd is in stable
  # config = lib.optionalAttrs (options ? systemd.settings) {
  #   systemd.settings.Manager = {
  #     DefaultTimeoutStopSec = "10s";
  #   };
  # };
  # --- common/core/settings/settings-systemd.nix

  # +++ common/core/settings/settings-other.nix
  # services.upower.enable = true;
  # security.polkit.enable = true;
  # --- common/core/settings/settings-other.nix

  environment.shellAliases = lib.mkForce { };
  nixpkgs.config.allowUnfree = true;

  # +++ common/core/settings/settings-nix.nix
  # nix = {
  #   # extraOptions = ''
  #   #   !include ${config.sops.secrets.nix_token.path}
  #   # '';
  #   settings = {
  #     connect-timeout = 5;
  #     fallback = true;
  #     log-lines = 25;
  #     min-free = 128000000; # 128MB
  #     max-free = 1000000000; # 1GB
  #     ###
  #     accept-flake-config = true;
  #     allow-dirty = true;
  #     auto-optimise-store = true;
  #     experimental-features = [
  #       "nix-command"
  #       "flakes"
  #     ];
  #     use-xdg-base-directories = true;
  #     warn-dirty = false;
  #     trusted-users = [
  #       # "${config.hostSpec.primaryUser.name}"
  #       "padd1er"
  #       "@wheel"
  #     ];
  #   };
  #   gc = {
  #     automatic = true;
  #     dates = "weekly";
  #     options = "--delete-older-than 3d";
  #   };
  # };
  # --- common/core/settings/settings-nix.nix

  # +++ common/optional/settings/settings-bluetooth.nix
  # hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;
  # services.blueman.enable = true;
  # --- common/optional/settings/settings-bluetooth.nix

  # +++ common/optional/settings/settings-cups-printer.nix
  # services.printing = {
  #   enable = true;
  #   listenAddresses = [ "*:631" ];
  #   allowFrom = [ "all" ];
  #   browsing = true;
  #   defaultShared = true;
  #   openFirewall = true;
  # };
  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  #   openFirewall = true;
  #   publish = {
  #     enable = true;
  #     userServices = true;
  #   };
  # };
  # --- common/optional/settings/settings-cups-printer.nix

  # +++ common/optional/settings/settings-sound.nix
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };
  # --- common/optional/settings/settings-sound.nix

  # +++ common/optional/settings/settings-ssd.nix
  # services.fstrim = {
  #   enable = true;
  #   interval = "weekly";
  # };
  # --- common/optional/settings/settings-ssd.nix

  # # User account
  # users.users.padd1er = {
  #   # CHANGE THIS
  #   isNormalUser = true;
  #   extraGroups = [
  #     "wheel"
  #     "networkmanager"
  #     "video"
  #   ];
  #   initialPassword = "changeme"; # Change after first boot!
  # };

  # Basic packages
  environment.systemPackages = with pkgs; [
    # Terminal and basics
    wezterm
    wget
    git
    vim
    neovim
    yazi
    sops
    ssh-to-age
    zellij

    # Niri essentials
    # fuzzel # App launcher
    # kanshi

    # Gaming
    # steam

    # File manager
    # nautilus
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Steam
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true;
  # };

  # Niri compositor
  # programs.niri = {
  #   enable = true;
  #   package = pkgs.niri;
  # };

  system.stateVersion = "25.11";

}
