{
  pkgs,
  ...
}:

{

  imports = [
  ];

  services = {
    gvfs = {
      enable = true;
    };

    tumbler.enable = true;
    # samba = {
    #   enable = true;
    #   nmbd.enable = true;
    # };

  };
  programs = {
    xfconf.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
