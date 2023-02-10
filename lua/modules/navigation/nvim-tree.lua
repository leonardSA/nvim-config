------------------------------------------------------------------------------- 
-- NVIM-TREE CONFIGURATION
------------------------------------------------------------------------------- 

local api = require("nvim-tree.api")
local system_extension_list = { png=true, svg=true } -- list of file extension to open with the system command 

-- Keymap entry point to our tree
vim.keymap.set('n', '<C-n>', api.tree.toggle)

------------------------------------------------------------------------------- 
-- Private functions

-- @brief Choose wether to open a file in vim or using the system 
-- E.g. .txt will be opened in vim but .png will be openend by the system
-- @system_extension_list List of file extensions to be opened with the system
local function node_open(system_extension_list) 
    local node = api.tree.get_node_under_cursor()
    print(node.extension)
    if node.extension == nil then
        api.node.open.edit(node)
    else
        if system_extension_list[node.extension] then
            api.node.run.system(node)
        else
            api.node.open.edit(node) 
        end
    end
end

-- @brief Open file in new tab from current tabpage and stay on current tabpage
local function node_open_tab()
    local tabpage_handler = vim.api.nvim_get_current_tabpage()
    api.node.open.tab()
    api.tree.focus()
    vim.api.nvim_set_current_tabpage(tabpage_handler) 
end
------------------------------------------------------------------------------- 

------------------------------------------------------------------------------- 
-- Keymapping

local function on_attach(bufnr)
    local bufopts = { buffer = bufnr }
    -- navigation
    vim.keymap.set('n', 'w',        api.node.navigate.parent_close,                             bufopts)
    vim.keymap.set('n', 'e',        api.tree.expand_all,                                        bufopts)
    vim.keymap.set('n', '<C-k>',    api.node.navigate.sibling.prev,                             bufopts)
    vim.keymap.set('n', '<C-j>',    api.node.navigate.sibling.next,                             bufopts)

    -- opening
    vim.keymap.set('n', '<CR>',     function() node_open(system_extension_list) end,            bufopts)
    vim.keymap.set('n', '<C-e>',    function() node_open_tab() end,                             bufopts)
    vim.keymap.set('n', '<Tab>',    api.node.open.preview,                                      bufopts)

    -- file operations
    vim.keymap.set('n', 'a',        api.fs.create,                                              bufopts)
    vim.keymap.set('n', 'r',        api.fs.rename,                                              bufopts)
    -- TODO: wrap in function to create directories on full rename
    vim.keymap.set('n', '<C-r>',    api.fs.rename_sub,                                          bufopts)
    vim.keymap.set('n', 'x',        api.fs.cut,                                                 bufopts)
    vim.keymap.set('n', 'c',        api.fs.copy.node,                                           bufopts)
    vim.keymap.set('n', 'p',        api.fs.paste,                                               bufopts)
    vim.keymap.set('n', 'd',        api.fs.remove,                                              bufopts)

    -- file info
    vim.keymap.set('n', 'y',        api.fs.copy.filename,                                       bufopts)
    vim.keymap.set('n', 'yy',       api.fs.copy.relative_path,                                  bufopts)
    vim.keymap.set('n', 'gy',       api.fs.copy.absolute_path,                                  bufopts)
    vim.keymap.set('n', '<S-k>',    api.node.show_info_popup,                                   bufopts)

    -- tree operations
    vim.keymap.set('n', 'q',        function() vim.cmd("NvimTreeClose")   end,                  bufopts)
end
------------------------------------------------------------------------------- 

require('nvim-tree').setup({
    tab = {
        sync = {
          open   = true,
          close  = true,
          ignore = {},
        },
    },
    renderer = {
        icons = {
            glyphs = {
                git = {
                    unstaged  = "~",
                    staged    = "+",
                    unmerged  = "",
                    renamed   = "➜",
                    untracked = "?",
                    deleted   = "-",
                    ignored   = "◌",
                },
            }
        },
    },
    remove_keymaps = true,
    on_attach = on_attach,
})
