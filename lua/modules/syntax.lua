------------------------------------------------------------------------------- 
-- SYNTAX CONFIGURATION
------------------------------------------------------------------------------- 
require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "lua", "vim", "rust", "python", "latex", "make" },
    highlight = {
        enable  = true,
        disable = { "" }, 
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = disable }, 
    incremental_selection = { enable = disable },
    sync_install = false, 
})
