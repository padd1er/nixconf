{
  pkgs,
  ...
}:

{

  imports = [
  ];

  environment.systemPackages = with pkgs; [
    yubioath-flutter
    yubikey-manager
    pam_u2f
    # pcsclite
  ];

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
    yubikey-agent.enable = true;
  };
  # services.pcscd.enable = true;
  # services.udev.packages = [ pkgs.yubikey-personalization ];
  # services.yubikey-agent.enable = true;
}
