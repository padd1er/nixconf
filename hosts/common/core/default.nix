{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./cli-packages.nix
    ./doas.nix
    ./neovim.nix
    ./nix.nix
    ./ssh.nix
    # ./system.nix
    # ./systemd.nix
  ];
}
