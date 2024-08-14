{
  pkgs ? (import <nixpkgs>) { },
}:
{
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      just
      neovim
      nix
      nix-output-monitor
      nvd
    ];
  };
}
