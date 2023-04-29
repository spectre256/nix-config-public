local function dial(action)
    return require("dial.map")[action]()
end

return {
    {
        "kylechui/nvim-surround",
        config = true,
        keys = {
            { "ds" },
            { "cs" },
            { "ys" },
        },
    },
    {
        "numToStr/comment.nvim",
        name = "Comment",
        config = true,
        keys = {
            { "gc", mode = { "n", "v" } },
        },
    },
    {
        "windwp/nvim-autopairs",
        config = true,
        event = "InsertEnter",
    },
    {
        "monaqa/dial.nvim",
        init = function()
            vim.keymap.set("n", "<C-a>", dial("inc_normal"), { desc = "Increment", noremap = true })
            vim.keymap.set("n", "<C-x>", dial("dec_normal"), { desc = "Decrement", noremap = true })
            vim.keymap.set("v", "<C-a>", dial("inc_visual"), { desc = "Increment visual mode", noremap = true })
            vim.keymap.set("v", "<C-x>", dial("dec_visual"), { desc = "Decrement visual mode", noremap = true })
            vim.keymap.set("v", "g<C-a>", dial("inc_gvisual"), { desc = "Increment sequence", noremap = true })
            vim.keymap.set("v", "g<C-x>", dial("dec_gvisual"), { desc = "Decrement sequence", noremap = true })
        end,
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.date.alias["%m/%d/%Y"],
                },
            })
        end,
    },
}
