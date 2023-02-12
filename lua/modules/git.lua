------------------------------------------------------------------------------- 
-- GIT CONFIGURATION
------------------------------------------------------------------------------- 
-- use gitsigns, vim-fugitive and telescope

-- @brief Replaces '<leader>' in string with global leader char.
-- @input string containing '<leader>'
local function replace_leader(input)
    return string.gsub(input, '<leader>', vim.g.mapleader)
end

local gs                 = require("gitsigns")
local git_signs_enabled  = false
local git_signs_setup    = false
local GS_SETUP_DELAY_MS  = 500
local GS_ATTACH_DELAY_MS = 5
local git_signs_keymaps  = {
    { mode = 'n', lhs = '<C-k>',                        rhs = gs.prev_hunk },
    { mode = 'n', lhs = '<C-j>',                        rhs = gs.next_hunk },
    { mode = 'n', lhs = replace_leader('<leader>a'),    rhs = gs.stage_hunk },
    { mode = 'v', lhs = replace_leader('<leader>a'),    rhs = gs.stage_hunk },
    { mode = 'n', lhs = replace_leader('<leader>u'),    rhs = gs.reset_hunk },
    { mode = 'v', lhs = replace_leader('<leader>u'),    rhs = gs.reset_hunk },
    { mode = 'n', lhs = replace_leader('<leader>p'),    rhs = gs.preview_hunk },
    { mode = 'n', lhs = replace_leader('<leader>d'),    rhs = ':Gitsigns diffthis<CR><C-w>w' },
    -- from tpope/vim-fugitive
    { mode = 'n', lhs = replace_leader('<leader>x'),    rhs = ':Git blame<CR><C-w>w' },
    -- from telescope
    { mode = 'n', lhs = replace_leader('<leader>c'),    rhs = require('telescope.builtin').git_commits },
    { mode = 'n', lhs = replace_leader('<leader>s'),    rhs = require('telescope.builtin').git_status },
    { mode = 'n', lhs = replace_leader('<leader>b'),    rhs = require('telescope.builtin').git_branches },
}

-- Keymap entry point to our git mode
vim.keymap.set('n', '<leader>gg', function() git_signs_toggle() end)

------------------------------------------------------------------------------- 
-- Private functions

-- will store the state of keys before entering git mode in order to restore them when exiting the mode
local original_keymaps_table = {}

-- @brief Stores mappings in original_keymaps_table
-- @modes modes for which to store the mappings
local function fill_original_keymaps_table(modes)
    for _, mode in ipairs(modes) do
        local keymap = vim.api.nvim_get_keymap(mode)
        original_keymaps_table[mode] = {}
        for _, mapping in ipairs(keymap) do
            -- register if not registered yet
            original_keymaps_table[mode][mapping.lhs] = {
                rhs     = mapping.rhs,
                bufopts = { noremap = mapping.noremap, silent = mapping.silent}
            }
        end
    end
end

-- @brief Restores mappings stored in original_keymaps_table
-- @mappings mappings having overwritten the original mappings
-- @buffer   buffer number
local function restore_original_keymaps_table(mappings, buffer)
    for _, keymap in ipairs(mappings) do
        -- delete local keymap
        vim.keymap.del(keymap.mode, keymap.lhs, { buffer = buffer or bufnr })
        -- if deleted keymap had overwritten an original keymap restore the latter
        if original_keymaps_table[keymap.mode] and original_keymaps_table[keymap.mode][keymap.lhs] then
            local original_keymap = original_keymaps_table[keymap.mode][keymap.lhs]
            vim.keymap.set(keymap.mode, keymap.lhs, original_keymap.rhs, original_keymap.bufopts)
        end
    end
    original_keymaps_table = {}
end

-- @brief For setup on_attach
-- @buffer do not use
local function on_attach(buffer)
    local bufopts = { buffer = bufnr }
    for _, keymap in ipairs(git_signs_keymaps) do
        vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, bufopts)
    end
end
------------------------------------------------------------------------------- 

------------------------------------------------------------------------------- 
-- Config

local setup_config = {
    signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '-' },
        topdelete    = { text = '-' },
        changedelete = { text = '-' },
        untracked    = { text = '?' },
    },
    attach_to_untracked = true,
    signcolumn = true,
    numhl      = true,
    linehl     = true,
    on_attach  = on_attach
}
------------------------------------------------------------------------------- 

------------------------------------------------------------------------------- 
-- Global functions

-- @brief Starts gitsigns on first call then allows for toggling it on and off.
-- First call takes GS_SETUP_DELAY_MS time.
-- Setup status is stored in git_signs_setup.
-- On/Off status is stored in git_signs_enabled.
-- Original keys stored in original_keymaps_table are possibly overwritten by special keys but restored on exit.
function git_signs_toggle()
    if git_signs_setup then 
        if git_signs_enabled then -- disable it
            restore_original_keymaps_table(git_signs_keymaps, bufnr)
            gs.detach_all()
            print("gitsigns is disabled")
        else -- enable it
            fill_original_keymaps_table({'n', 'v'})
            for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buffer) then
                    gs.attach(buffer)
                    -- TODO: find method to wait for async task return
                    -- wait for buffer to attach itself in order to avoid sync issues
                    vim.wait(GS_ATTACH_DELAY_MS, function() return false end)
                end
            end
            print("gitsigns is enabled")
        end
        git_signs_enabled = not git_signs_enabled
    else
        fill_original_keymaps_table({'n', 'v'})

        -- TODO: find method to wait for async task return
        -- wait for gitsigns to set itself up in order to be able to fetch the autocommands
        -- this operation will always wait for a constant amount of time
        vim.wait(GS_SETUP_DELAY_MS, require('gitsigns').setup(setup_config))

        -- redefine autocmds defined by gitsigns in order for it to not reactivate itself at inconvenient times
        local undesirable_autocmds = vim.api.nvim_get_autocmds({
            group = "gitsigns",
            event = { "BufWritePost", "BufReadPost" }
        })
        for _, aucmd in ipairs(undesirable_autocmds) do
            vim.api.nvim_del_autocmd(aucmd.id)
        end
        vim.api.nvim_create_autocmd({"BufWritePost", "BufReadPost"}, {
            group = "gitsigns",
            callback = 
                function() 
                    if git_signs_enabled then vim.cmd(':Gitsigns attach') end 
                end
        })
        
        -- update statuses
        git_signs_setup   = true
        git_signs_enabled = true
        print("gitsigns is setup and enabled")
    end
end
------------------------------------------------------------------------------- 
