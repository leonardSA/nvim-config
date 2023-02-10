------------------------------------------------------------------------------- 
-- TERMINAL CONFIGURATION
------------------------------------------------------------------------------- 

-- Keymap entry points to terminal
vim.keymap.set('n', '<S-t>', ':tabnew<CR>:terminal<CR>i') -- directly go into insert mode
vim.keymap.set('n', '<C-t>', ':FloatermNew --height=1.0 --width=0.4 --wintype=vsplit<cr>')

------------------------------------------------------------------------------- 
-- Terminal navigation

-- <C-\><C-n> allows you to return to normal mode in terminal 
-- Note that two \\ are required to escape the character
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>') 
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-w>l')
------------------------------------------------------------------------------- 

------------------------------------------------------------------------------- 
-- Terminal autocommands

-- disable line numbers for terminal
vim.api.nvim_create_autocmd('TermOpen', {
    command = 'setlocal nonumber norelativenumber'
})
------------------------------------------------------------------------------- 
