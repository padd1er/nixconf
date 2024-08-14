{ pkgs
, lib
, config
, ...
}:

{
  imports =
    [
      ./cli-main.nix
      ./cli-other.nix
      ./doas.nix
      ./gui-main.nix
      ./neovim.nix
    ];

  app-cli-main.enable = lib.mkDefault true;
  app-cli-other.enable = lib.mkDefault false;
  app-doas.enable = lib.mkDefault true;
  app-gui-main.enable = lib.mkDefault false;
  app-neovim.enable = lib.mkDefault true;
}

