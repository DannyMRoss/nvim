return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        r_language_server = {
          mason = false,
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
                diagnosticSeverityOverrides = {
                  reportMissingImports = "warning",
                  reportMissingModuleSource = "none",
                  reportUnusedImport = "none",
                  reportUnusedVariable = "none",
                },
              },
            },
          },
        },
      },
    },
  },
}
