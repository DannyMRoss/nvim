return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- drop the clock and the extra widgets (git diff, dap, noice, lazy updates)
    opts.sections.lualine_x = {}
    opts.sections.lualine_z = {}
    -- drop the progress % and line:col location
    opts.sections.lualine_y = {}
    -- drop the git branch
    opts.sections.lualine_b = {}
    -- just mode (lualine_a) + filetype icon + file name
    opts.sections.lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename", path = 1 },
    }
    return opts
  end,
}
