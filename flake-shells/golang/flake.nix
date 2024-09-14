{
  description = "Golang dev shell flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      devShells."x86_64-linux".default = pkgs.mkShell {

        name = "Golang dev shell";

        packages = [
          pkgs.go
          pkgs.gotools
          pkgs.gofumpt
          pkgs.gomodifytags
          pkgs.impl
          pkgs.delve
          pkgs.gopls
        ];

        shellHook = '''';
      };

    };

}
