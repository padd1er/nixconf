{ pkgs
, lib
, config
, ...
}:

{
  options = {
    app-neovim.enable = lib.mkEnableOption "enables app-neovim";
  };

  config = lib.mkIf config.app-neovim.enable {

    environment.systemPackages = with pkgs; [
      neovim
      stylua
      tree-sitter
      bash-language-server
      docker-compose-language-service
      yaml-language-server
      taplo
      shfmt
      shellcheck
      ruff
      pyright
      prettierd
      marksman
      markdownlint-cli2
      vimPlugins.vim-markdown-toc
      lua-language-server
      hadolint
      dockerfile-language-server-nodejs
      black
      rnix-lsp
    ];
  };
}
