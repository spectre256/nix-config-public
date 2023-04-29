return {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
        "spectre256/start.nvim",
        dev = true,
        enabled = false,
        -- event = "VeryLazy"
        lazy = false,
        config = function()
            require("start").setup()
        end,
    },
    {
        "spectre256/statusline.nvim",
        dev = true,
        enabled = true,
        -- event = "VeryLazy"
        -- lazy = false,
        config = function()
            require("statusline").setup()
        end,
    },
    {
        "spectre256/repl.nvim",
        dev = true,
        enabled = true,
        -- event = "VeryLazy"
        -- lazy = false,
        config = function()
            require("repl").setup()
        end,
    },
}
