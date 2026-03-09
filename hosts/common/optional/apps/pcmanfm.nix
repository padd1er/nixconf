{
  pkgs,
  ...
}:

{

  imports = [
  ];

  environment.systemPackages = with pkgs; [
    lxqt.pcmanfm-qt
    lxqt.libfm-qt
    lxqt.lxqt-menu-data
    lxqt.lxqt-policykit

  ];

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };

}
