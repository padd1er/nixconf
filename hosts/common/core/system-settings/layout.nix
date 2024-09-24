{
  ...
}:

{

  services.xserver.xkb.layout = "pl-bel";
  services.xserver.xkb.options = "lv3:ralt_switch";
  services.xserver.xkb.extraLayouts.pl-bel = {
    description = "PL layout with Belarusian symbols";
    languages = [ "pl" ];
    symbolsFile = ./symbols/pl-bel;
  };
  services.xserver.exportConfiguration = true;

  # programs.dconf = {
  #   enable = true;
  #   profiles.user.databases = [
  #     {
  #       settings = {
  #         "org/gnome/desktop/input-sources" = {
  #           xkb-options = "['lv3:ralt_switch' 'compose:ralt']";
  #           sources = "[('xkb', 'pl')]";
  #         };
  #       };
  #     }
  #   ];
  # };
  # system.activationScripts.dconfReset = {
  #   text = ''
  #     dconf reset -f /org/gnome/desktop/input-sources/
  #   '';
  # };
}
