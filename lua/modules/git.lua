------------------------------------------------------------------------------- 
-- GIT CONFIGURATION
------------------------------------------------------------------------------- 
-- use gitsigns, vim-fugitive and telescope

local gs                 = require("gitsigns")
local git_signs_enabled  = false
local git_signs_setup    = false
local GS_SETUP_DELAY_MS  = 500
local GS_ATTACH_DELAY_MS = 5

-- Keymap entry point to our git mode
vim.keymap.set('n', '<leader>gg', function() git_signs_toggle() end)

------------------------------------------------------------------------------- 
-- Private functions

-- @brief Attach or detach keymaps to a buffer
-- @attach attach if true else detach
-- @bufnum buffer to attach or detach
local function attach_or_detach_keymaps(attach, buffer)
    local function map_or_unmap(map, mode, l, r, opts)
        if map == true then
            vim.keymap.set(mode, l, r, opts)
        else
            vim.keymap.del(mode, l, opts)
        end
    end

    local bufopts = { buffer = buffer or bufnr }

    -- local to gitsigns
    map_or_unmap(attach, 'n',        '<C-k>',       gs.prev_hunk,                      bufopts)
    map_or_unmap(attach, 'n',        '<C-j>',       gs.next_hunk,                      bufopts)
    map_or_unmap(attach, {'n', 'v'}, '<leader>a',   gs.stage_hunk,                     bufopts)
    map_or_unmap(attach, {'n', 'v'}, '<leader>u',   gs.reset_hunk,                     bufopts)
    map_or_unmap(attach, 'n',        '<leader>p',   gs.preview_hunk,                   bufopts)
    map_or_unmap(attach, 'n',        '<leader>d',   ':Gitsigns diffthis<CR><C-w>w',    bufopts)

    -- from tpope/vim-fugitive
    map_or_unmap(attach, 'n',        '<leader>b',   ':Git blame<CR><C-w>w',            bufopts) 
end

-- @brief For setup on_attach
local function on_attach(bufnr)
    attach_or_detach_keymaps(true, _)
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
function git_signs_toggle()
    if git_signs_setup then 
        if git_signs_enabled then -- disable it
            -- attach_or_detach_keymaps(false, bufnr)
            gs.detach_all()
            print("gitsigns is disabled")
        else -- enable it
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
