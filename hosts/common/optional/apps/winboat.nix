{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    podman
    podman-compose
    podman-tui
    podman-desktop
    winboat
  ];
}
