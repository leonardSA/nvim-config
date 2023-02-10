------------------------------------------------------------------------------- 
-- COLORSCHEME CONFIGURATION
------------------------------------------------------------------------------- 

require("tokyonight").setup({
    style = "stormy",
    on_colors = -- make diff highlights and git indications more vibrant
        function(colors)
            colors.diff = {
                add    = "#37516A", -- modified
                change = "#38415F", -- modified
                delete = "#3f2d3d",
                text   = "#394b70"
            }
            colors.git = {
                add    = "#4AC694", -- modified
                change = "#FFF4BD", -- modified
                delete = "#c47981",
                ignore = "#545c7e"
            }
            colors.gitSigns = {
                add    = "#4AC694", -- modified
                change = "#FFF4BD", -- modified
                delete = "#c25d64" 
            }
        end
})
vim.cmd("colorscheme tokyonight")
