
--local settings = require("user-conf")
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
  return string.format('require("config/%s")', name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer...")
  vim.api.nvim_command("packadd packer.nvim")
end

-- initialize and configure packer
local packer = require("packer")

packer.init({
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function(use)

  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim")
-- ======================================
  -- actual plugins list
-- comments
   use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

-- ======================================
-- Tokyonight Colorscheme
   use 'folke/tokyonight.nvim'
-- nightfox
   use "EdenEast/nightfox.nvim"

-- ======================================
   use "kyazdani42/nvim-web-devicons"
-- Nvim-tree
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
    }

-- ======================================
-- Lualine
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

-- ======================================
-- Gitsigns
    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = get_config("gitsigns"),
    }) 

-- ======================================
-- Autopairs
   use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}  


-- ======================================
-- Bufferline
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

-- ======================================
-- Toggle Term
    use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
      require("toggleterm").setup()
    end}

-- ======================================
-- Lazygit
  use "kdheepak/lazygit.nvim"

-- ======================================
end)

