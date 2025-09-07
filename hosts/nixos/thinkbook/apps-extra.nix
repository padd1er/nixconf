{
  pkgs,
  ...
}:

{

  imports = [
  ];

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    jujutsu
    claude-code
  ];
}
