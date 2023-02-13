------------------------------------------------------------------------------- 
-- TELESCOPE CONFIGURATION
------------------------------------------------------------------------------- 

local builtin       = require('telescope.builtin')
local actions       = require('telescope.actions')
local actions_state = require('telescope.actions.state')

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

-- @brief Look for a opened buffer corresponding to the filename through every windows of every tab.
-- @filename absolute path to file
-- @return tab=tabpage_id, win=window_id if found else tab=nil, win=nil
local function get_tabpage_and_window(filename)
    local tabs = vim.api.nvim_list_tabpages()
    for _, tab in ipairs(tabs) do
        local windows = vim.api.nvim_tabpage_list_wins(tab)
        for _, window in ipairs(windows) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(window))
            if filename == bufname then
                return tab, window
            end
        end
    end
    return nil, nil 
end

-- @brief Opens a file in a new buffer if it is not already opened else switches to the opened buffer.
-- @prompt_bufnr current buffer aka buffer in which to open the file if it is not opened yet
local function find_files_open(prompt_bufnr) 
    local entry    = actions_state.get_selected_entry()
    local filename = entry['cwd'] .. '/' .. entry.value
    local tab, win = get_tabpage_and_window(filename)
    if nil == tab then -- open file
        actions.select_default(prompt_bufnr)
    else -- switch to file
        vim.api.nvim_set_current_tabpage(tab)
        vim.api.nvim_set_current_win(win)
    end
end

-- @brief Opens a file in a new buffer if it is not already opened else switches to the opened buffer.
-- @prompt_bufnr current buffer aka buffer in which to open the file if it is not opened yet
local function buffers_open(prompt_bufnr)
    local filename = vim.fn.getcwd() .. '/' .. actions_state.get_selected_entry().filename
    local tab, win = get_tabpage_and_window(filename)
    if nil == tab then -- open file
        actions.select_default(prompt_bufnr)
    else -- switch to file
        vim.api.nvim_set_current_tabpage(tab)
        vim.api.nvim_set_current_win(win)
    end
end

-- @brief Opens a file in a new buffer if it is not already opened else switches to the opened buffer.
-- @prompt_bufnr current buffer aka buffer in which to open the file if it is not opened yet
local function git_status_open(prompt_bufnr)
    local filename = actions_state.get_selected_entry().path
    local tab, win = get_tabpage_and_window(filename)
    if nil == tab then -- open file
        actions.select_default(prompt_bufnr)
    else -- switch to file
        vim.api.nvim_set_current_tabpage(tab)
        vim.api.nvim_set_current_win(win)
    end
end

-- @brief Opens a file in a new buffer if it is not already opened else switches to the opened buffer.
-- @prompt_bufnr current buffer aka buffer in which to open the file if it is not opened yet
local function live_grep_open(prompt_bufnr)
    local entry    = actions_state.get_selected_entry()
    local filename = vim.fn.getcwd() .. '/' .. entry.filename
    local tab, win = get_tabpage_and_window(filename)
    if nil == tab then -- open file
        actions.select_default(prompt_bufnr)
    else -- switch to file
        vim.api.nvim_set_current_tabpage(tab)
        vim.api.nvim_win_set_cursor(win, { entry.lnum, entry.col })
    end
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
        live_grep = {
            mappings = {
                i = { ["<CR>"] = live_grep_open, },
                n = { ["<CR>"] = live_grep_open, },
            },
        },
        git_status = {
            preview_title = false,
            mappings = {
                i = { ["<CR>"] = git_status_open, },
                n = { ["<CR>"] = git_status_open, },
            },
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
