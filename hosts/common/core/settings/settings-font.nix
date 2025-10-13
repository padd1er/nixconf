{
  pkgs,
  ...
}:

{
  # system font
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [ nerd-fonts.hack ];
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Hack Nerd Font Mono" ];
    };
  };

  # tty font
  console = {
    earlySetup = true;
    packages = [ pkgs.terminus_font ];
    font = "ter-v14n";
    useXkbConfig = true;
  };

  systemd.services.systemd-vconsole-setup.unitConfig.After = "local-fs.target";
}
