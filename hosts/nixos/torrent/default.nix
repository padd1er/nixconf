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
    ./apps-extra.nix
    ./sunshine.nix
    (map libCustom.relativeToRoot [
      "modules/common/host-spec.nix"
      "hosts/common/core"
      "hosts/common/users/primary"
      "hosts/common/optional/settings/settings-bluetooth.nix"
      "hosts/common/optional/settings/settings-cups-printer.nix"
      "hosts/common/optional/settings/settings-sound.nix"
      "hosts/common/optional/settings/settings-ssd.nix"
      "hosts/common/optional/settings/settings-ssh.nix"
      "hosts/common/optional/settings/settings-yubikey-lock.nix"
      "hosts/common/optional/apps/all-cli.nix"
      "hosts/common/optional/apps/all-gui.nix"
      "hosts/common/optional/apps/camera.nix"
      "hosts/common/optional/apps/distrobox.nix"
      "hosts/common/optional/apps/gaming.nix"
      "hosts/common/optional/apps/libreoffice.nix"
      "hosts/common/optional/apps/piper-tts.nix"
      "hosts/common/optional/apps/qmk.nix"
      "hosts/common/optional/apps/thunar.nix"
      "hosts/common/optional/apps/wezterm.nix"
      "hosts/common/optional/apps/winboat.nix"
      "hosts/common/optional/apps/yubikey.nix"
      "hosts/common/optional/user-environments/greetd.nix"
      "hosts/common/optional/user-environments/niri.nix"
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

  networking.hostName = "${config.hostSpec.name}-nixos";

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

  environment.shellAliases = lib.mkForce { };

  # environment.systemPackages = with pkgs; [
  #   brightnessctl
  #   coolercontrol.coolercontrol-gui
  #   coolercontrol.coolercontrold
  #   coolercontrol.coolercontrol-ui-data
  #   lm_sensors
  #   # nvidia stuff
  #   vulkan-tools
  #   vulkan-loader
  #   vulkan-validation-layers
  #   mangohud
  #   gamemode
  #   wineWowPackages.stable
  #   winetricks
  #   protontricks
  #   # anker camera
  #   cameractrls
  #   cameractrls-gtk4
  #   # rustdesk
  #   xdg-desktop-portal-wlr
  # ];

  # programs.coolercontrol.enable = true;

  system.stateVersion = "25.11";
}
