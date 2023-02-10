------------------------------------------------------------------------------- 
-- TELESCOPE CONFIGURATION
------------------------------------------------------------------------------- 

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

------------------------------------------------------------------------------- 
-- Keymapping

-- files binds
vim.keymap.set('n', '<C-p>', builtin.find_files)
vim.keymap.set('n', '<A-p>g', builtin.live_grep)
-- buffers binds
vim.keymap.set('n', '<A-p>t', builtin.buffers)
-- git binds
vim.keymap.set('n', '<A-p>s', builtin.git_status)
vim.keymap.set('n', '<A-p>c', builtin.git_commits)
vim.keymap.set('n', '<A-p>b', builtin.git_branches)
------------------------------------------------------------------------------- 

require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<Tab>"]   = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["<C-j>"]   = actions.preview_scrolling_down,
                ["<C-k>"]   = actions.preview_scrolling_up,
                ["<C-e>"]   = actions.select_tab,
            },
            n = {
                ["<Tab>"]   = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["<C-j>"]   = actions.preview_scrolling_down,
                ["<C-k>"]   = actions.preview_scrolling_up,
                ["<C-e>"]   = actions.select_tab,
                ["<C-c>"]   = actions.close,
            },
        },
        dynamic_preview_title = true,
        layout_strategy = 'horizontal',
        layout_config = {
            width = 0.99,
            height = 0.9,
        },
    },
    pickers = {
        buffers = {
            preview_title = false,
        },
        find_files = {
            prompt_title = 'Search Project',
        },
        oldfiles = {
            prompt_title = 'Search File History',
        },
        git_status = {
            preview_title = false,
        },
        git_commits = {
            preview_title = false,
        },
        git_branches = {
            theme = 'dropdown',
            preview_title = false,
        },
    },
})
