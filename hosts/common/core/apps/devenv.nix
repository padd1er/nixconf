{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    devenv
    direnv
    nix-direnv
  ];
}
