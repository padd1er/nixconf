{ pkgs, lib, config, ... }:

{

  options = {
    app-cli-other.enable = lib.mkEnableOption "enables app-cli-other";
  };

  config = lib.mkIf config.app-cli-other.enable {
    environment.systemPackages = with pkgs; [
      dysk
      fselect
      grex
      hyperfine
      lemmeknow
      miniserve
      navi
      pastel
    ];
  };
}

