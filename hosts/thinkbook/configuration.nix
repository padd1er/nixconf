{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  system,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disko.nix
    ../common/core/default.nix
    ../common/core/system.nix
    ../common/core/systemd.nix
    ../common/users/padd1er/default.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkbook-nixos";

  services.libinput.enable = true;

  system.stateVersion = "24.05";
}
