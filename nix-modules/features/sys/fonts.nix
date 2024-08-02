{ pkgs, lib, config, ... }:

{
  options = {
    sys-fonts.enable = lib.mkEnableOption "enables sys-fonts";
  };

  config = lib.mkIf config.sys-fonts.enable {
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

    console = {
      packages = [ pkgs.terminus_font ];
      font = "ter-v14n";
      keyMap = "us";
      useXkbConfig = false;
    };
  };
}
