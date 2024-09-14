{
  ...
}:

{
  services.xserver.xkb.layout = "pl";
  services.xserver.exportConfiguration = true;
  services.xserver.xkb.options = "lv3:ralt_switch";
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
