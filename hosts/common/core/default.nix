{
  lib,
  libCustom,
  ...
}:

{
  imports = lib.flatten [
    (libCustom.scanPaths ./.)
  ];
}
