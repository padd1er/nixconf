{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{

  options = {
    app-cli-main.enable = lib.mkEnableOption "enables app-cli-main";
  };

  config = lib.mkIf config.app-cli-main.enable {
    environment.systemPackages = with pkgs; [
      atuin
      bat
      bottom
      cargo
      inputs.nixpkgs-stable.legacyPackages."${pkgs.system}".delta # NOTE: this is instead lf default rustdesk which is at 1.2.3 version and fails to build due to rust 1.80.0 https://github.com/NixOS/nixpkgs/issues/332957
      eza
      fd
      file
      fzf
      gcc
      git
      gnugrep
      gnumake
      gping
      jq
      just
      killall
      lazydocker
      lazygit
      lf
      libxml2
      lua
      macchina
      mise
      ninja
      nix-output-monitor
      nix-search-cli
      nodejs
      nvd
      openssl
      pandoc
      procs
      python3
      ripgrep
      shfmt
      sops
      starship
      stow
      unar
      unzip
      wget
      yazi
      zellij
      zip
      zlib
      zoxide
      exiftool
      gtrash
    ];
    programs.fish.enable = true;
  };
}
