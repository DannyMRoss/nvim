return {
  "folke/which-key.nvim",
  opts = {
    -- never auto-show the popup; pull it up manually with <leader>? if needed
    delay = 10000,
    preset = "modern",
  },
  keys = {
    {
      "<leader>?",
      function()
        -- root the popup at <leader> itself so it shows the leader
        -- cheatsheet (e.g. <leader>E), not just buffer-local mappings
        require("which-key").show({ keys = "<leader>", loop = true })
      end,
      desc = "Buffer + Global Keymaps (which-key)",
    },
  },
}
