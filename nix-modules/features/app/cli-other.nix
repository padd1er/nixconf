{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{

  options = {
    app-cli-other.enable = lib.mkEnableOption "enables app-cli-other";
  };

  config = lib.mkIf config.app-cli-other.enable {
    environment.systemPackages = with pkgs; [
      act
      dysk
      fselect
      grex
      hyperfine
      inputs.nixpkgs-stable.legacyPackages."${pkgs.system}".miniserve # NOTE: this is instead lf default rustdesk which is at 1.2.3 version and fails to build due to rust 1.80.0 https://github.com/NixOS/nixpkgs/issues/332957
      lemmeknow
      navi
      pastel
    ];
  };
}
