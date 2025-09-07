{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [ sudo-rs ];

  security = {
    sudo = {
      enable = false;
    };
    sudo-rs = {

      enable = true;
      execWheelOnly = false;
      wheelNeedsPassword = false;
    };
  };
}
