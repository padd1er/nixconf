{
  pkgs,
  ...
}:

{
  # system font
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "Hack" ]; }) ];
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Hack Nerd Font Mono" ];
    };
  };

  # tty font
  console = {
    packages = [ pkgs.terminus_font ];
    font = "ter-v14n";
    useXkbConfig = true;
  };
}
