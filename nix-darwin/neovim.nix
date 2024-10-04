{ pkgs, ... }:
{
  enable = true;
  plugins =
    with pkgs.vimPlugins;
    [
      oil-nvim
      nvim-web-devicons

      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-path
      cmp-vsnip

      nvim-dap
      nvim-nio
      nvim-dap-ui

      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      fzf-lua

      nvim-treesitter

      vim-vsnip
      nvim-lspconfig
      tokyonight-nvim
      copilot-lua
    ]
    ++ [
      nvim-treesitter-parsers.asm
      nvim-treesitter-parsers.cpp
      nvim-treesitter-parsers.gitcommit
      nvim-treesitter-parsers.diff
      nvim-treesitter-parsers.gitignore
      nvim-treesitter-parsers.git_config
      nvim-treesitter-parsers.git_rebase
      nvim-treesitter-parsers.javascript
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.toml
      nvim-treesitter-parsers.typescript
      nvim-treesitter-parsers.vim
      nvim-treesitter-parsers.yaml
      nvim-treesitter-parsers.go
      nvim-treesitter-parsers.rust
    ];
  viAlias = true;
}
