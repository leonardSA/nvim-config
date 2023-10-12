------------------------------------------------------------------------------- 
-- COMPLETION CONFIGURATION
------------------------------------------------------------------------------- 
local cmp = require('cmp')

------------------------------------------------------------------------------- 
-- Configure UltiSnips as snippet engine
vim.g.UltiSnipsJumpForwardTrigger  = '<c-k>'
vim.g.UltiSnipsJumpBackwardTrigger = '<c-j>'
-- cannot set lua way
vim.cmd("let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/lua/modules/completion/snips']")
------------------------------------------------------------------------------- 

------------------------------------------------------------------------------- 
-- Configure completion engine
cmp.setup({
    snippet = {
        expand = 
            function(args)
                vim.fn["UltiSnips#Anon"](args.body)
            end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<Tab>']   = cmp.mapping.confirm({ select = true }),
        ['<C-p>']   = cmp.mapping.select_next_item(),
        ['<C-n>']   = cmp.mapping.select_prev_item(),
        ['<C-f>']   = cmp.mapping.scroll_docs(4),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),

    }),

    sources = cmp.config.sources({ 
        { name = 'nvim_lsp',  keyword_length = 3 }, 
        { name = 'ultisnips', keyword_length = 2 },  
        { name = 'buffer',    keyword_length = 3 }, 
        { name = 'path'                          }, 
    }),

    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = 
            function(entry, item)
                local menu_icon ={
                    nvim_lsp  = '', -- icon is nf-dev-vim
                    ultisnips = '', -- icon is nf-cod-record_keys
                    buffer    = '', -- icon is nf-code-note
                    path      = '', -- icon is nf-fa-desktop
                }
                item.menu = menu_icon[entry.source.name]
                return item
            end,
    },
})
------------------------------------------------------------------------------- 
