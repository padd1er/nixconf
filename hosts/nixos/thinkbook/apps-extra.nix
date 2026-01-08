{
  pkgs,
  overlays,
  ...
}:

{

  imports = [
  ];
  nixpkgs.overlays = [
    overlays.easyeffects
  ];

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    jujutsu
    claude-code
    nmap
    easyeffects
  ];
}
