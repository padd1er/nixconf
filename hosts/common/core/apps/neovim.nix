{
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    bash-language-server
    black
    vtsls
    # typescript-language-server
    docker-compose-language-service
    # TODO: remove "if" when dockerfile-language-server goes stable
    (
      if lib.hasAttr "dockerfile-language-server" pkgs then
        dockerfile-language-server
      else
        dockerfile-language-server-nodejs
    )
    # dockerfile-language-server-nodejs
    # dockerfile-language-server
    eslint_d
    hadolint
    hyprls
    lua-language-server
    luajitPackages.luarocks
    markdownlint-cli2
    marksman
    neovim
    nixd
    # nixfmt-rfc-style # NOTE: renamed to nixfmt
    nixfmt
    statix
    # TODO: remove "if" when prettier goes stable
    (if lib.hasAttr "prettier" pkgs then prettier else nodePackages.prettier)
    # prettierd
    # prettier
    pyright
    ruff
    shellcheck
    shfmt
    stylua
    taplo
    tree-sitter
    vimPlugins.nvim-treesitter-parsers.hyprlang
    vimPlugins.vim-markdown-toc
    vscode-langservers-extracted
    # inputs.nixpkgs-stable.legacyPackages."${pkgs.stdenv.hostPlatform.system}".vscode-langservers-extracted
    yaml-language-server
    wl-clipboard
  ];

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    defaultEditor = true;
  };
}
