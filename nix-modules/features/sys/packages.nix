{ pkgs, lib, config, ... }:

{

  options = {
    sys-packages.enable = lib.mkEnableOption "enables sys-packages";
  };

  config = lib.mkIf config.sys-packages.enable {
    environment.systemPackages = with pkgs; [
      gcc
      jq
      gnumake 
      nodejs
      python3
      unzip
      zip
      gnugrep
      openssl
      ninja
      pandoc
      zlib
      # ?
      cargo
      stylua
      tree-sitter
    ];
  };
}

