{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    slack
    telegram-desktop
    vesktop
    discord
    discord-gamesdk
    discord-rpc
    zapzap
    slack
    zoom-us
  ];
}
