{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.sessionVariables = { };

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "yes";
}
