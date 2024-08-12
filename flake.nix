{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-cosmic, ... }@inputs: {
    nixosConfigurations = {
      thinkbook-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          ./hosts/thinkbook/configuration.nix
        ];
      };

      wsl-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          inputs.nixos-wsl.nixosModules.default
          {
            system.stateVersion = "24.05";
            wsl.enable = true;
          }
          ./hosts/wsl/configuration.nix
        ];
      };

      ugreen-vm = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/ugreen-vm/configuration.nix
        ];
      };
    };
  };
}
