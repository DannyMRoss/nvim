return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
