{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    app-neovim.enable = lib.mkEnableOption "enables app-neovim";
  };

  config = lib.mkIf config.app-neovim.enable {

    environment.systemPackages = with pkgs; [
      bash-language-server
      black
      docker-compose-language-service
      dockerfile-language-server-nodejs
      hadolint
      lua-language-server
      markdownlint-cli2
      marksman
      neovim
      nixfmt-rfc-style
      prettierd
      pyright
      ruff
      shellcheck
      shfmt
      stylua
      taplo
      tree-sitter
      vimPlugins.vim-markdown-toc
      yaml-language-server
      # nodePackages.vscode-json-languageserver
      vscode-langservers-extracted
      eslint_d
      nixd
      luajitPackages.luarocks
    ];

    programs.neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      defaultEditor = true;
    };
  };
}
