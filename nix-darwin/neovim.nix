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
    ++ (with nvim-treesitter-parsers; [
      asm
      cpp
      diff
      git_config
      git_rebase
      gitcommit
      gitignore
      go
      javascript
      json
      latex
      lua
      nix
      python
      rust
      toml
      typescript
      vim
      yaml
    ]);
  viAlias = true;
}
