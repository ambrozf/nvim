local themes = {
  default = {}, -- the default Neovim theme
  nightfox = {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("core.plugins.themes.nightfox")
    end,
  },
  github_light = {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup()

      vim.cmd("colorscheme github_light")
    end,
  },
  tundra = {
    "sam4llis/nvim-tundra",
    priority = 1000,
    lazy = false,
    config = function()
      require("core.plugins.themes.tundra")
    end,
  },
  tokyonight = {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("core.plugins.themes.tokyonight")
    end,
  },
  kanagawa = {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("core.plugins.themes.kanagawa")
    end,
  },
  oxocarbon = {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd("colorscheme oxocarbon")
    end,
  },
  catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("core.plugins.themes.catppuccin")
    end,
  },
}

local selectedTheme = themes[vim.g.config.theme.name]

return selectedTheme
