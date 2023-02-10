------------------------------------------------------------------------------- 
-- LSP CONFIGURATION
------------------------------------------------------------------------------- 

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'rust_analyzer', 
        'clangd' 
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

------------------------------------------------------------------------------- 
-- Keymapping

local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    --
    vim.keymap.set('n', '<S-k>',     vim.lsp.buf.hover,              bufopts)
    vim.keymap.set('n', 'gD',        vim.lsp.buf.declaration,        bufopts)
    vim.keymap.set('n', 'gd',        vim.lsp.buf.definition,         bufopts)
    vim.keymap.set('n', 'gr',        vim.lsp.buf.references,         bufopts)

    -- workspace related
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,                                        bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,                                     bufopts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
end
------------------------------------------------------------------------------- 

------------------------------------------------------------------------------- 
-- Servers configuration

require('lspconfig').clangd.setup({
    on_attach    = on_attach,
    capabilities = capabilities,
    cmd          = { "clangd" }
})

require('rust-tools').setup({
    server = {
        on_attach    = on_attach,
        capabilities = capabilities,
    }
})
------------------------------------------------------------------------------- 

-- FIXME: does not start on file open ; has to manually call LspStart
-- FIXME: does not work with rustlings but does with a hello world example
-- require('lspconfig').rust_analyzer.setup({
--     on_attach    = on_attach,
--     capabilities = capabilities,
--     settings     = {
--         ["rust-analyzer"] = {
--             imports = {
--                 granularity = { group = "module", },
--                 prefix = "self",
--             },
--             cargo = {
--                 buildScripts = { enable = true, },
--             },
--             procMacro = { enable = true },
--         }
--     },
--     cmd = { "rustup", "run", "stable", "rust-analyzer" }
-- })
