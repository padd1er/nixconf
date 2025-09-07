# { inputs, ... }:
# {
#   imports = [ inputs.argon40-nix.nixosModules.default ];
#
#   programs.argon.one = {
#     enable = true;
#     settings = {
#       displayUnits = "celsius";
#
#       fanspeed = [
#         {
#           temperature = 40;
#           speed = 30;
#         }
#         {
#           temperature = 50;
#           speed = 70;
#         }
#         {
#           temperature = 60;
#           speed = 100;
#         }
#       ];
#     };
#   };
# }
#
{
  inputs,
  config,
  lib,
  pkgs,
  argononed,
  ...
}:
{
  imports = [
    "${inputs.argononed}/OS/nixos/default.nix"
  ];

  services.argonone = {
    enable = true;
    logLevel = 4;
    settings = {
      fanTemp0 = 41;
      fanSpeed0 = 20;
      fanTemp1 = 46;
      fanSpeed1 = 50;
      fanTemp2 = 51;
      fanSpeed2 = 80;
      hysteresis = 4;
    };
  };
}
