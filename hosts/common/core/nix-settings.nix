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
      substituters = [
        "https://cosmic.cachix.org/"
        "https://wezterm.cachix.org"
      ];
      trusted-public-keys = [
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      ];
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
