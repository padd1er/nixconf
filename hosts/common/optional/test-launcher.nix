{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    anyrun
    bemenu
    fuzzel
    nwg-drawer
    rofi-wayland
    sysmenu
    tofi
    walker
    wofi
    yofi
  ];
}
