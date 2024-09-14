{
  inputs,
  ...
}:

{
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };
}
