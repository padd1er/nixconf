{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disko.nix
    ../common/core/default.nix
    ../common/users/padd1er/default.nix
    ../common/optional/user-environments/hypr.nix
    ../common/optional/cli-packages.nix
    ../common/optional/gui-packages.nix
    ../common/optional/setup-ssh-agent.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkbook-nixos";

  services.libinput.enable = true;

  system.stateVersion = "24.05";
}
