------------------------------------------------------------------------------- 
-- GENERAL KEYMAPPING
------------------------------------------------------------------------------- 
-- leader configuration
vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '
-- common keymapping
vim.keymap.set('n', '<C-e>',     ':tabedit<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>o', ':only<CR>')
-- navigate splits in normal mode with ALT-Key
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')
------------------------------------------------------------------------------- 

------------------------------------------------------------------------------- 
-- GLOBALS
------------------------------------------------------------------------------- 
vim.g.python3_host_prog = 'python3'
vim.g.updatetime        = 750
------------------------------------------------------------------------------- 

------------------------------------------------------------------------------- 
-- OPTIONS
------------------------------------------------------------------------------- 
-- appearance
vim.opt.background      = 'dark'
-- navigation
vim.opt.scrolloff       = 999
vim.opt.cursorline      = true
vim.opt.relativenumber  = true
vim.opt.colorcolumn     = '120'
-- tabulations
vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 4
vim.opt.softtabstop     = 4
vim.opt.expandtab       = true
vim.opt.smarttab        = true
vim.opt.autoindent      = true
-- copy paste
vim.opt.clipboard       = 'unnamedplus'
------------------------------------------------------------------------------- 
