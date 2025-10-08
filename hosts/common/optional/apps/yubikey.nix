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

    # login.u2fAuth = true;
    # sudo = {
    #   u2fAuth = true;
    #   # sshAgentAuth = true; # Use SSH_AUTH_SOCK for sudo
    # };
  };

  # TODO: deal with this
  # security.pam = {
  #   services = {
  #     login = {
  #       u2fAuth = true;
  #       unixAuth = true;
  #     };
  #     sudo = {
  #       u2fAuth = true;
  #       unixAuth = true;
  #     };
  #     lightdm = {
  #       u2fAuth = true;
  #       unixAuth = true;
  #     };
  #   };
  #   # sshAgentAuth.enable = true;
  #   u2f = {
  #     enable = true;
  #     settings = {
  #       cue = true;
  #       authFile = "$HOME/.ssh/u2f_keys";
  #     };
  #   };
  # };

  # yubikey login / sudo
  # security.pam = lib.optionalAttrs pkgs.stdenv.isLinux {
  #   sshAgentAuth.enable = true;
  #   u2f = {
  #     enable = true;
  #     settings = {
  #       cue = true; # Tells user they need to press the button
  #       authFile = "${homeDirectory}/.config/Yubico/u2f_keys";
  #     };
  #   };

  # services.pcscd.enable = true;
  # services.udev.packages = [ pkgs.yubikey-personalization ];
  # services.yubikey-agent.enable = true;
}
