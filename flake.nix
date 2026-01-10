{
  description = "NixOS config flake";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cosmic.cachix.org/"
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  inputs = {
    ### NIXOS ###

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    ### NIXOS-COMMUNITY ###

    # NOTE: https://github.com/nix-community/disko/blob/master/docs/disko-install.md#disko-install
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    ### OTHER ###

    # NOTE: https://github.com/lilyinstarlight/nixos-cosmic#usage
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NOTE: https://github.com/0xc000022070/zen-browser-flake#installation
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NOTE: https://github.com/Mic92/sops-nix#usage-example
    sops-nix.url = "github:mic92/sops-nix";

    # NOTE: https://github.com/nvmd/nixos-raspberrypi#add-flake-input
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scopebuddy.url = "github:HikariKnight/ScopeBuddy";

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dgop = {
    #   url = "github:AvengeMedia/dgop";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      libCustom = import ./lib { inherit (nixpkgs) lib; };
      overlays = import ./overlays;
      baseSpecialArgs = {
        inherit
          inputs
          outputs
          nixpkgs
          libCustom
          overlays
          self
          ;
      };
      cacheModule = {
        nix.settings.substituters = [
          "https://nix-community.cachix.org"
          "https://cosmic.cachix.org/"
          "https://nixos-raspberrypi.cachix.org"
        ];
        nix.settings.trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
          "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        ];
      };
    in
    {
      nixosConfigurations = {
        torrent-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = baseSpecialArgs;
          modules = [
            ./hosts/nixos/torrent
            cacheModule
          ];
        };
        thinkbook-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = baseSpecialArgs;
          modules = [
            ./hosts/nixos/thinkbook
            cacheModule
          ];
        };
        ideapad-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = baseSpecialArgs;
          modules = [
            ./hosts/nixos/ideapad
            cacheModule
          ];
        };
        box-nixos = inputs.nixos-raspberrypi.lib.nixosSystem {
          specialArgs = baseSpecialArgs // {
            nixos-raspberrypi = inputs.nixos-raspberrypi;
          };
          modules = [
            inputs.nixos-raspberrypi.nixosModules.raspberry-pi-4.base
            inputs.nixos-raspberrypi.nixosModules.raspberry-pi-4.display-vc4
            inputs.nixos-raspberrypi.nixosModules.raspberry-pi-4.bluetooth
            cacheModule
            ./hosts/nixos/box
          ];
          system = "aarch64-linux";
        };
        wsl-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = baseSpecialArgs;
          system = "x86_64-linux";
          modules = [
            ./hosts/nixos/wsl
            cacheModule
          ];
        };
      };
    };
}
