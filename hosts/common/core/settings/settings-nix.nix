{
  config,
  lib,
  inputs,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.secrets = {
    nix_token = {
      mode = "0440";
    };
  };

  environment.shellAliases = lib.mkForce { };
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      !include ${config.sops.secrets.nix_token.path}
    '';
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
      trusted-users = [
        "${config.hostSpec.primaryUser.name}"
        "@wheel"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };
}
