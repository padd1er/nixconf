{
  description = "NixOS config flake";
  inputs = {
    ### NIXOS STUFF ###
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    hardware.url = "github:nixos/nixos-hardware";

    ### OTHER ###
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flake-compat.url = "github:edolstra/flake-compat";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
      specialArgs = {
        inherit inputs outputs nixpkgs;
      };
    in
    {
      nixosConfigurations = {
        thinkbook-nixos = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./hosts/thinkbook/configuration.nix ];
        };
        wsl-nixos = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [ ./hosts/wsl/configuration.nix ];
        };
      };
    };
}
