{
  pkgs,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    distrobox
    distrobox-tui
    podman
    podman-compose
    podman-tui
    podman-desktop
  ];
}
