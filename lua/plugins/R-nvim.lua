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
            if vim.bo.filetype == "quarto" then
              -- quarto chunks can be R or python: dispatch `,` based on the
              -- language of the chunk under the cursor instead of always
              -- sending to R (which otherwise shadows iron's send-to-python)
              vim.keymap.set("n", ",", function()
                if require("r.utils").get_lang() == "python" then
                  require("iron.core").send_line()
                  vim.cmd("normal! j")
                else
                  require("r.send").line("move")
                end
              end, { buffer = true, desc = "Send line to R/Python REPL" })

              vim.keymap.set("v", ",", function()
                if require("r.utils").get_lang() == "python" then
                  require("iron.core").visual_send()
                else
                  require("r.send").selection(false)
                end
              end, { buffer = true, desc = "Send selection to R/Python REPL" })
            else
              vim.api.nvim_buf_set_keymap(0, "n", ",", "<Plug>RDSendLine", {})
              vim.api.nvim_buf_set_keymap(0, "v", ",", "<Plug>RSendSelection", {})
            end
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
