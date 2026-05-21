---@diagnostic disable: undefined-global
return {
  {
    "R-nvim/R.nvim",
    -- Only required if you also set defaults.lazy = true
    lazy = false,
    config = function()
      -- Create a table with the options to be passed to setup()
      ---@type RConfigUserOpts
      local opts = {
        hook = {
          on_filetype = function()
            vim.api.nvim_buf_set_keymap(0, "n", ",", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", ",", "<Plug>RSendSelection", {})
            vim.api.nvim_buf_set_keymap(0, "i", "<C-`>", "<-", {})
            vim.api.nvim_buf_set_keymap(0, "n", "<localleader>dd", "<Plug>RClearConsole", { desc = "Clear console" })
            vim.api.nvim_buf_set_keymap(
              0,
              "n",
              "<localleader>dg",
              ":RSend graphics.off() <CR>",
              { desc = "Clear graphics" }
            )
            vim.keymap.set("n", "<localleader>dr", function()
              local file = vim.fn.expand("%:p")
              local pdf = vim.fn.expand("%:r") .. ".pdf"

              -- Rend:aer asynchronously
              vim.fn.jobstart({ "quarto", "render", file }, {
                on_exit = function()
                  -- Open in Skim after render completes
                  vim.fn.jobstart({ "open", "-a", "Skim", pdf }, { detach = true })
                end,
                detach = true,
              })
            end, { desc = "Quarto render + open in Skim" })
          end,
        },
        R_args = { "--quiet", "--no-save" },
        min_editor_width = 72,
        rconsole_width = 78,
        ---disable_cmds = {
        ---    "RClearConsole",
        ---    "RCustomStart",
        ---    "RSPlot",
        ---    "RSaveClose",
        ---},
      }
      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == "true" then
        opts.auto_start = "on startup"
        opts.objbr_auto_start = true
      end
      require("r").setup(opts)
    end,
  },
}
