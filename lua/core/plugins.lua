------------------------------------------------------------------------------- 
-- PLUGINS INSTALLATION
------------------------------------------------------------------------------- 

-- bootstrap packer installation
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
use 'wbthomason/packer.nvim'

    use { -- syntax
        'nvim-treesitter/nvim-treesitter',
    }

    use { -- comment
        'tpope/vim-commentary',           -- easy commenting
        'vim-scripts/DoxygenToolkit.vim', -- easy documentation
    }

    use { -- ui
        'nvim-tree/nvim-web-devicons',    -- icons: necessary for lualine and nvim-tree
        'folke/tokyonight.nvim',          -- colorscheme
        'nvim-lualine/lualine.nvim',
    }

    use {  -- navigation
        'voldikss/vim-floaterm',          -- to better position the terminal easily
        'nvim-tree/nvim-tree.lua',
        'nvim-telescope/telescope.nvim', tag = '0.1.1', -- or branch = '0.1.x' for constant releases
        'nvim-lua/plenary.nvim',          -- required by telescope
    }

    use { -- git integration
      'lewis6991/gitsigns.nvim', tag = 'release',
      requires = { { 'tpope/vim-fugitive' } }   -- dependant because vim-fugitive is configured by/for gitsigns 
    }

    use { -- lsp integration
        'williamboman/mason.nvim',              -- lsp manager (actually an extensive package manager)
        'williamboman/mason-lspconfig.nvim',    -- lspconfig manager
        'neovim/nvim-lspconfig',                -- configurations for nvim lsp
        'simrat39/rust-tools.nvim'              -- configurations for rust-analyzer lsp
    }

    use { -- completion integration
        'hrsh7th/nvim-cmp',                     -- completion client
        'hrsh7th/cmp-nvim-lsp',                 -- completion for lsp
        'hrsh7th/cmp-buffer',                   -- completion for opened buffer
        'hrsh7th/cmp-path',                     -- completion for file system
        'SirVer/ultisnips',                     -- completion for ultisnips
        'quangnguyen30192/cmp-nvim-ultisnips',  -- links ultisnips to the completion client
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
