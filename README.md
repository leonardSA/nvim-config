# nvim-config

## Requirements and dependencies

```sh
# Minimal version: NVIM v0.8+
# Requirements: 
# - nodejs and neovim
# - python3 and python3-neovim

# Installing neovim
sudo apt install neovim         # !!: version might be <v0.8x
sudo dpkg -i nvim-linux64.deb   # after downloading deb package

# Installing Node support
# You may to update your source list (https://github.com/nodesource/distributions)
sudo apt install nodejs         # !!: version might be <v16.x
npm install -g neovim           # install node support for neovim 

# Installing Python support
sudo apt install python3
python3 -m pip install python3-neovim

# Installing clipboard support 
sudo apt install xclip
```

## Plugins

All plugins are installed via [packer](https://github.com/wbthomason/packer.nvim) in **core/plugins.lua**.  
All plugins configuration files are set in the **module** directory.

| **Category** | **Plugin** | **Configuration File** |
|---|---|---|
| comment | [vim-scripts/DoxygenToolkit.vim](https://github.com/vim-scripts/DoxygenToolkit.vim) | comment.lua |
| comment | [tpope/vim-commentary](https://github.com/tpope/vim-commentary) | comment.lua |
| navigation | [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | navigation/nvim-tree.lua |
| navigation | [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | navigation/telescope.lua |
| terminal | [voldikss/vim-floaterm](https://github.com/voldikss/vim-floaterm) | terminal.lua |
| git | [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | git.lua |
| git | [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) | git.lua |
| lsp | [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) | lsp.lua |
| lsp | [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | lsp.lua |
| lsp | [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | lsp.lua |
| lsp | [simrat39/rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim) | lsp.lua |
| completion | [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | cmp.lua |
| completion | [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | cmp.lua |
| completion | [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | cmp.lua |
| completion | [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) | cmp.lua |
| completion | [quangnguyen30192/cmp-nvim-ultisnips](https://github.com/quangnguyen30192/cmp-nvim-ultisnips) | cmp.lua |
| completion | [SirVer/ultisnips](https://github.com/SirVer/ultisnips) | cmp.lua |
| syntax | [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | syntax.lua |
| ui | [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | |
| ui | [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | |
| ui | [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | colorscheme.lua |
| | [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | |

## Keybindings

| **File** | **Mode** | **Keybind** | **Command** | **Description** |
|---|---|---|---|---|
| general.lua | n | \<C-e\> | :tabedit | Open a new tab |
|  | n | \<leader\>w | :w | Write to buffer |
|  | n | \<leader\>q | :q | Quit buffer |
|  | n | \<leader\>o | :only | Close all windows but the selected one |
|  | n | \<A-h\> | \<C-w\>h | Navigate to window left to current window |
|  | n | \<A-j\> | \<C-w\>j | Navigate to window under current window |
|  | n | \<A-k\> | \<C-w\>k | Navigate to window on top of current window |
|  | n | \<A-l\> | \<C-w\>l | Navigate to window right to current window |
| comment.lua | n, v | \<leader\>c | :Commentary | Comment out a line |
|  | n | \<leader\>d | :Dox | Generate a Doxygen style comment |
| navigation/nvim-tree.lua | n | \<C-n\> | :NvimTreeToggle | Toggle NvimTree |
|  | n | q | :NvimTreeClose | In tree: close tree |
|  | n | w | api.node.navigate.parent\_close | In tree: close parent node |
|  | n | e | api.tree.expand\_all | In tree: expand all child nodes |
|  | n | \<C-k\> | api.node.navigate.sibling.prev | In tree: go to previous sibling |
|  | n | \<C-j\> | api.node.navigate.sibling.next | In tree: go to next sibling  |
|  | n | \<CR\> | *node\_open* | In tree: open node in current buffer |
|  | n | \<C-e\> | *node\_open\_tab* | In tree: open node in new tab but stay in current buffer |
|  | n | \<Tab\> | api.node.open.preview | In tree: preview node in current buffer |
|  | n | a | api.fs.create | In tree: create a new file |
|  | n | r | api.fs.rename | In tree: rename a file |
|  | n | \<C-r\> | api.fs.rename\_sub | In tree: rename a file and it's path |
|  | n | x | api.fs.cut | In tree: cut a file |
|  | n | c | api.fs.copy.node | In tree: copy a file |
|  | n | p | api.fs.paste | In tree: paste a file |
|  | n | d | api.fs.remove | In tree: delete a file |
|  | n | y | api.fs.copy.filename | In tree: copy filename |
|  | n | yy | api.fs.copy.relative\_path | In tree: copy filename and it's relative path |
|  | n | gy | api.fs.copy.absolute\_path | In tree: copy filename and it's absolute path |
|  | n | \<S-k\> | api.node.show\_info\_popup | In tree: show basic file info |
| navigation/telescope.lua | n | \<C-p\> | builtin.find\_files | Look for file in cwd and subdirs |
|  | n | \<A-p\>g | builtin.live\_grep | Look for string in files in cwd and subdirs |
|  | n | \<A-p\>h | builtin.oldfiles | Look for file in list of recently opened files |
|  | n | \<A-p\>b | builtin.buffers | Look for file currently opened in a buffer |
|  | i, n | \<CR\> | *open* | In picker: select, action depends on picker |
|  | i, n | \<Tab\> | actions.move\_selection\_next | In picker: go to next item |
|  | i, n | \<S-Tab\> | actions.move\_selection\_previous | In picker: go to previous item |
|  | i, n | \<C-j\> | actions.preview\_scrolling\_down | In picker: scroll down in preview |
|  | i, n | \<C-k\> | actions.preview\_scrolling\_up | In picker: scroll up in preview |
|  | i, n | \<C-e\> | actions.select\_tab | In picker: open in new tab, actions depends on picker |
|  | n | \<C-c\> | actions.close | In picker: close picker |
| terminal.lua | n | \<leader\>t | :tabnew\<CR\>:terminal\<CR\>i | Open a terminal in a new tab |
|  | n | \<C-t\> | :FloatermNew --height=1.0 --width=0.4 --wintype=vsplit | Open a terminal in a split window in current buffer |
|  | t | \<Esc\> | \<C-\\\>\<C-n\> | In terminal: exit insert mode |
|  | t | \<A-h\> | \<C-\\\>\<C-n\>\<C-w\>h | In terminal: navigate to left window |
|  | t | \<A-j\> | \<C-\\\>\<C-n\>\<C-w\>j | In terminal: navigate to down window |
|  | t | \<A-k\> | \<C-\\\>\<C-n\>\<C-w\>k | In terminal: navigate to top window |
|  | t | \<A-l\> | \<C-\\\>\<C-n\>\<C-w\>l | In terminal: navigate to right window |
| git.lua | n | \<leader\>gg | *git\_signs\_toggle* | Toggle git mode |
|  | n | \<C-k\> | gs.prev\_hunk | In git mode: go to previous hunk |
|  | n | \<C-j\> | gs.next\_hunk | In git mode: go to next hunk |
|  | n, v | \<leader\>a | gs.stage\_hunk | In git mode: stage hunk |
|  | n, v | \<leader\>u | gs.reset\_hunk | In git mode: reset hunk |
|  | n | \<leader\>p | gs.preview\_hunk | In git mode: preview hunk diffs in floating window  |
|  | n | \<leader\>d | :Gitsigns diffthis\<CR\>\<C-w\>w | In git mode: preview file diffs in split window |
|  | n | \<leader\>x | :Git blame\<CR\>\<C-w\>w | In git mode: open git blame output in split window |
|  | n | \<leader\>c | require('telescope.builtin').git\_commits | In git mode: open search for git commits ; select checks out onto commit |
|  | n | \<leader\>s | require('telescope.builtin').git\_status | In git mode: open search for git status ; select opens file |
|  | n | \<leader\>b | require('telescope.builtin').git\_branches | In git mode: open search for git branches ; select checks out onto branch |
| lsp.lua | n | \<S-k\> | vim.lsp.buf.hover | Open documentation in floating window |
|  | n | gD | vim.lsp.buf.declaration | Go to declaration |
|  | n | gd | vim.lsp.buf.definition | Go to definition |
|  | n | gr | vim.lsp.buf.references | Browse references in split window |
| completion/cmp.lua |  | \<Tab\> | cmp.mapping.confirm({ select = true }) | Select top completion |
|  |  | \<C-p\> | cmp.mapping.select\_next\_item() | Go to next completion |
|  |  | \<C-n\> | cmp.mapping.select\_prev\_item() | Go to previous completion |
|  |  | \<C-j\> | vim.g.UltiSnipsJumpForwardTrigger | Go to next placeholder in snippet |
|  |  | \<C-k\> | vim.g.UltiSnipsJumpBackwardTrigger | Go to previous placeholder in snippet |
