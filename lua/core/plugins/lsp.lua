local conf = vim.g.config

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "onsails/lspkind-nvim" },
      { "folke/neoconf.nvim", config = true, ft = "lua" }, -- must be loaded before lsp
    },
    config = function()
      require("core.plugins.lsp.lsp")
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    opts = {
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
    },
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        module = "mason",
        opts = {
          handlers = {
            ["jdtls"] = function()
              --require("lspconfig").jdtls.setup() -- Add this line for using the wrapped jdtls.setup
            end,
          },
        },
      },
    },
    config = function()
      -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
      require("mason").setup()

      -- ensure tools (except LSPs) are installed
      local mr = require("mason-registry")
      local function install_ensured()
        for _, tool in ipairs(conf.tools) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(install_ensured)
      else
        install_ensured()
      end

      require("mason-nvim-dap").setup()
      require("mason-tool-installer").setup({
        ensure_installed = {
          --"lombok-nightly",
          "java-debug-adapter",
          "java-test",
        },

        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
        vim.api.nvim_command("MasonToolsInstall"),
      })
      -- install LSPs
      require("mason-lspconfig").setup({ ensure_installed = conf.lsp_servers })
    end,
  },
}
