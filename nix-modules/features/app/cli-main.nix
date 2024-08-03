{ pkgs, lib, config, ... }:

{

  options = {
    app-cli-main.enable = lib.mkEnableOption "enables app-cli-main";
  };

  config = lib.mkIf config.app-cli-main.enable {
    environment.systemPackages = with pkgs; [
      atuin
      bat
      bottom
      delta
      eza
      fd
      fzf
      gcc
      git
      gnumake 
      gping
      just
      lazydocker
      lazygit
      lf
      macchina
      mise
      neovim
      nh
      nodejs
      procs
      python3
      ripgrep
      shfmt
      sops
      starship
      stow
      vim
      wget
      yazi
      zellij
      zoxide
    ];
    programs.fish.enable = true;
  };
}

