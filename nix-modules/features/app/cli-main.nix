{ pkgs
, lib
, config
, ...
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
      delta
      eza
      fd
      fzf
      gcc
      git
      gnugrep
      gnumake
      gnumake
      gping
      jq
      just
      lazydocker
      file
      lazygit
      lf
      macchina
      mise
      neovim
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
      stylua
      tree-sitter
      unzip
      vim
      wget
      yazi
      zellij
      zip
      zlib
      zoxide
      libxml2
    ];
    programs.fish.enable = true;
  };
}

