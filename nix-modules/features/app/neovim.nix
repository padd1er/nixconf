{
  config,
  inputs,
  lib,
  pkgs,
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
      eslint_d
      hadolint
      hyprls
      lua-language-server
      luajitPackages.luarocks
      markdownlint-cli2
      marksman
      neovim
      nixd
      nixfmt-rfc-style
      prettierd
      pyright
      ruff
      shellcheck
      shfmt
      stylua
      taplo
      tree-sitter
      vimPlugins.nvim-treesitter-parsers.hyprlang
      vimPlugins.vim-markdown-toc
      # vscode-langservers-extracted
      inputs.nixpkgs-stable.legacyPackages."${pkgs.system}".vscode-langservers-extracted
      yaml-language-server
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
