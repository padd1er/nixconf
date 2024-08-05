{ pkgs
, lib
, config
, ...
}:

{
  imports =
    [
      ./ssh-agent.nix
    ];

  service-ssh-agent.enable = lib.mkDefault true;
}


