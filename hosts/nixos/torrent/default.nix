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
      "hosts/common/optional/settings/settings-ssh.nix"
      "hosts/common/optional/settings/settings-bluetooth.nix"
      "hosts/common/optional/settings/settings-sound.nix"
      "hosts/common/optional/settings/settings-cups-printer.nix"
      "hosts/common/optional/settings/settings-yubikey-lock.nix"
      "hosts/common/optional/settings/settings-ssd.nix"
      "hosts/common/optional/apps/all-cli.nix"
      "hosts/common/optional/apps/all-gui.nix"
      "hosts/common/optional/apps/qmk.nix"
      "hosts/common/optional/apps/gaming.nix"
      "hosts/common/optional/apps/libreoffice.nix"
      "hosts/common/optional/apps/wezterm.nix"
      "hosts/common/optional/apps/piper-tts.nix"
      "hosts/common/optional/apps/yubikey.nix"
      # # "hosts/common/optional/user-environments/xfce.nix"
      "hosts/common/optional/user-environments/greetd.nix"
      "hosts/common/optional/user-environments/niri.nix"
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
  nixpkgs.config.allowUnfree = true;

  # Basic packages
  environment.systemPackages = with pkgs; [
    # telegram-desktop
    # ghostty
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "25.11";

}
