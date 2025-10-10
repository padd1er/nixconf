{
  ...
}:

{
  networking.networkmanager.enable = true;
  networking.enableIPv6 = false;
  networking.firewall.enable = false;
  boot.kernelParams = [ "ipv6.disable=1" ];
}
