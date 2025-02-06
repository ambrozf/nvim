local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
      },
    },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "nvim-lua/plenary.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
}

M.execs = {
  "lua_ls",
  "cssls",
  "html",
  "ts_ls",
  "astro",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "marksman",
  "tailwindcss",
  "eslint",
}

function M.config()
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })
  require("mason-lspconfig").setup({
    ensure_installed = M.execs,
    automatic_installation = false,
  })
  require("mason-nvim-dap").setup()
  require("mason-tool-installer").setup({
    ensure_installed = {
      "java-debug-adapter",
      "java-test",
    },

    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
    vim.api.nvim_command("MasonToolsInstall"),
  })
end

return M
