{
  pkgs,
  config,
  ...
}:

let
  userName = config.hostSpec.primaryUser.name;
in
{
  environment.systemPackages = with pkgs; [
    yubioath-flutter
    yubikey-manager
    pam_u2f
    yubikey-personalization
    pamtester
    age-plugin-yubikey
  ];

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
    yubikey-agent.enable = true;
  };

  sops.secrets.yubikey_u2f_keys = {
    sopsFile = config.sops.defaultSopsFile;
  };

  sops.templates."u2f_keys" = {
    content = ''
      ${userName}:${config.sops.placeholder.yubikey_u2f_keys}
    '';
    mode = "0444";
  };

  security.pam = {
    u2f = {
      enable = true;
      settings = {
        cue = true;
        authfile = config.sops.templates."u2f_keys".path;
        origin = "pam://nixos-yubikey";
        appid = "pam://nixos-yubikey";
      };
      control = "sufficient";
    };
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
      sudo-i.u2fAuth = true;
      lightdm.u2fAuth = true;
      polkit-1.u2fAuth = true;
      gdm.u2fAuth = true;
      sddm.u2fAuth = true;
    };
  };
}
