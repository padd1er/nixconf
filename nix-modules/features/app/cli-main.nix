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
      git
      gping
      just
      lazydocker
      lazygit
      lf
      macchina
      mise
      neovim
      procs
      ripgrep
      shfmt
      starship
      stow
      vim
      wget
      yazi
      zellij
    ];
    programs.fish.enable = true;
  };
}

