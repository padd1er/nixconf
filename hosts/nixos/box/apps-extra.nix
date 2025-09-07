{
  nixos-raspberrypi,
  pkgs,
  ...
}:

{

  imports = [
    nixos-raspberrypi.nixosModules.nixpkgs-rpi
  ];

  environment.systemPackages =
    with pkgs;
    [
      i2c-tools
    ]
    ++ (with nixos-raspberrypi.packages.aarch64-linux; [
      libpisp
      libraspberrypi
      raspberrypi-utils
      raspberrypi-udev-rules
      raspberrypi-eeprom
    ]);
}
