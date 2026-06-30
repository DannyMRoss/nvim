return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = vim.env.SSH_CONNECTION and {}
      or { "javascript", "typescript", "lua", "markdown", "vim", "python", "r", "latex", "yaml", "git_config", "gitcommit", "gitignore" },
    auto_install = vim.env.SSH_CONNECTION == nil,
    highlight = { enable = true },
    ignore_install = { "rexx" },
  },
}
