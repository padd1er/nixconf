{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.shellAliases = lib.mkForce { };
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      connect-timeout = 5;
      fallback = true;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB
      ###
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
}
