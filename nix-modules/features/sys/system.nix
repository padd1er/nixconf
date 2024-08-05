{ pkgs
, lib
, config
, ...
}:

{
  options = {
    sys-system.enable = lib.mkEnableOption "enables sys-system";
  };

  config = lib.mkIf config.sys-system.enable {

    environment.sessionVariables = {
      FLAKE = "/root/nixconf";
    };
    time.timeZone = "Europe/Warsaw";

    # locale
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.UTF-8";
      LC_IDENTIFICATION = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_NUMERIC = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };

    # sound
    hardware.pulseaudio.enable = lib.mkForce false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # network
    networking.networkmanager.enable = true;
    networking.enableIPv6 = false;
    networking.firewall.enable = false;

    # system font
    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
        (nerdfonts.override { fonts = [ "Hack" ]; })
      ];
      fontconfig = {
        enable = true;
        defaultFonts.monospace = [ "Hack Nerd Font Mono" ];
      };
    };

    # tty font
    console = {
      packages = [ pkgs.terminus_font ];
      font = "ter-v14n";
      keyMap = "us";
      useXkbConfig = false;
    };

    # bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    # cups printer
    services.printing = {
      enable = true;
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };

    };
  };
}

