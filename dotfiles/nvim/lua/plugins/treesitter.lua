local function treesj(option)
    return function()
        require("treesj")[option]()
    end
end

return {
    {
        "nvim-treesitter/playground",
        cmd = { "TSPlaygroundToggle" },
        keys = {
            {
                "<leader>tp",
                "<Cmd>TSPlaygroundToggle<CR>",
                desc = "Toggle playground",
            },
        },
    },
    {
        "Wansmer/treesj",
        opts = {
            use_default_keymaps = false,
        },
        keys = {
            {
                "<leader>tt",
                treesj("toggle"),
                desc = "Toggle node under cursor",
            },
            {
                "<leader>ts",
                treesj("split"),
                desc = "Split node under cursor",
            },
            {
                "<leader>tj",
                treesj("join"),
                desc = "Join node under cursor",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "lua",
                "c",
                "python",
                "haskell",
                "nix",
                "json",
                "bash",
                "regex",
                "vim",
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            playground = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
        build = ":TSUpdate",
        event = "BufWinEnter",
    },
}
