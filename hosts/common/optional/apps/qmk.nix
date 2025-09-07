{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    qmk
    qmk-udev-rules
    qmk_hid
  ];

  hardware.keyboard.qmk.enable = true;
}
