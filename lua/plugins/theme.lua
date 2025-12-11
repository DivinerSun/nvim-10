return {
{ "catppuccin/nvim", name = "catppuccin", priority = 1000,
init = function()
-- 设置主题
vim.cmd.colorscheme("catppuccin")
end,
opts = {
transparent_background = true,
float = {
        transparent = true,
    },
    styles = {
        comments = { "italic", "bold" },
        conditionals = { "italic" },
        loops = {},
        functions = { "italic", "bold" },
        keywords = { "italic", "bold" },
        strings = { "bold" },
        variables = { "bold" },
        numbers = { "bold" },
        booleans = { "bold" },
        properties = { "bold" },
        types = { "bold" },
        operators = { "bold" },
    },
} }
}
