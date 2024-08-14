{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    sys-nixos.enable = lib.mkEnableOption "enables sys-nixos";
  };

  config = lib.mkIf config.sys-nixos.enable {
    environment.shellAliases = lib.mkForce { };
    nixpkgs.config.allowUnfree = true;

    nix = {
      settings = {
        accept-flake-config = true;
        allow-dirty = true;
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        use-xdg-base-directories = true;
        warn-dirty = false;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 3d";
      };
    };
  };
}
