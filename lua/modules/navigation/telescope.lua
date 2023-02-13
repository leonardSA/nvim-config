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
vim.keymap.set('n', '<A-p>b', builtin.buffers)
------------------------------------------------------------------------------- 

------------------------------------------------------------------------------- 
-- Private functions

-- @brief Opens a file in a new buffer if it is not already opened else switches to the opened buffer.
-- @prompt_bufnr current buffer aka buffer in which to open the file if it is not opened yet
local function find_files_open(prompt_bufnr) 
    local entry = require('telescope.actions.state').get_selected_entry()
    -- get absolute path to file to compare with bufname
    local filename = entry['cwd'] .. '/' .. entry.value

    -- look for a corresponding buffer through every windows of every tab
    local tabs = vim.api.nvim_list_tabpages()
    for _, tab in ipairs(tabs) do
        local windows = vim.api.nvim_tabpage_list_wins(tab)
        for _, window in ipairs(windows) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(window))
            if filename == bufname then -- switch to tab where file is opened and exit
                vim.api.nvim_set_current_tabpage(tab)
                vim.api.nvim_set_current_win(window)
                return
            end
        end
    end

    -- file is not opened yet
    actions.select_default(prompt_bufnr)
end

local function buffers_open(prompt_bufnr)
    local entry = require('telescope.actions.state').get_selected_entry()
    local target_buffer = entry.bufnr

    -- look for a corresponding buffer through every windows of every tab
    local tabs = vim.api.nvim_list_tabpages()
    for _, tab in ipairs(tabs) do
        local windows = vim.api.nvim_tabpage_list_wins(tab)
        for _, window in ipairs(windows) do
            local buffer = vim.api.nvim_win_get_buf(window)
            if target_buffer == buffer then -- switch to tab where file is opened and exit
                vim.api.nvim_set_current_tabpage(tab)
                vim.api.nvim_set_current_win(window)
                return
            end
        end
    end

    -- file is not opened yet
    actions.select_default(prompt_bufnr)
end

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
            mappings = {
                i = { ["<CR>"] = buffers_open, },
                n = { ["<CR>"] = buffers_open, },
            },
        },
        find_files = {
            prompt_title = 'Search Project',
            mappings = {
                i = { ["<CR>"] = find_files_open, },
                n = { ["<CR>"] = find_files_open, },
            },
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
