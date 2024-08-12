{ pkgs ? (import <nixpkgs>) { } }: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      nix
      just
      git
      neovim
    ];
  };
}
