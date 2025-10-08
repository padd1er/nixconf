{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    inputs.nixpkgs-stable.legacyPackages."${pkgs.system}".qmk
    # TODO: Compatibility with CMake < 3.5 has been removed from CMake - unstable
    # NOTE: https://github.com/NixOS/nixpkgs/issues/445447
    # qmk
    qmk-udev-rules
    qmk_hid
  ];

  hardware.keyboard.qmk.enable = true;
}
