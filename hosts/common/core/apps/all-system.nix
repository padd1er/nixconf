{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    cargo
    file
    gcc
    libxml2
    lua
    ninja
    nodejs
    openssl
    pciutils
    python3
    zlib
  ];
}
