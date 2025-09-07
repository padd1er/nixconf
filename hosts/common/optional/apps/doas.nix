{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [ doas ];

  security = {
    sudo = {
      enable = false; # NOTE: this is due to issues with using doas for nixos build/test/switch
    };
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [
            "wheel"
            "sudo"
          ];
          noPass = true;
          keepEnv = true;
        }
      ];
    };
  };
}
