return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "macchiato",
            styles = {
                comments = { "italic" },
                keywords = { "italic" },
            },
            highlight_overrides = {
                all = function(colors)
                    return {
                        NormalFloat = { fg = colors.text, bg = colors.base },
                        MatchParen = { fg = colors.none, bg = colors.surface1, style = { "bold" } },
                        -- CursorLineNr = { fg = colors.lavender, bg = colors.base, style = { "bold" } },
                    }
                end,
            },
            integrations = {
                treesitter = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
        build = ":CatppuccinCompile",
        lazy = false,
        priority = 1000, -- ensures the colorscheme gets loaded when starting
    },
    {
        "folke/noice.nvim",
        init = function()
            local function noice(cmd)
                return function()
                    require("noice").cmd(cmd)
                end
            end

            vim.keymap.set("n", "g<", noice("history"), { desc = "Fix g< to work with Noice", silent = true })
        end,
        opts = {
            cmdline = {
                view = "cmdline",
            },
            lsp = {
                -- override markdown rendering so that cmp and other plugins use Treesitter
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- default to using split view for everything
            messages = {
                view = "split",
                view_error = "split",
                view_warn = "split",
                view_history = "split",
                view_search = "mini",
            },
            popupmenu = {
                enabled = false,
            },
            commands = {
                last = {
                    view = "split",
                },
                errors = {
                    view = "split",
                },
            },
            notify = {
                view = "split",
            },
            views = {
                split = {
                    size = "30%",
                    enter = true,
                    close = {
                        keys = { "q", "<C-c>" },
                    },
                },
                mini = {
                    position = { col = 0 },
                },
            },
            routes = {
                {
                    filter = { -- everything with a height of 3 or less gets routed to mini
                        any = {
                            { event = "msg_show" },
                            { event = "notify" },
                            { error = true },
                            { warning = true },
                            { event = "lsp", kind = "message" },
                        },
                        max_height = 3,
                    },
                    view = "mini",
                },
                {
                    filter = {
                        any = {
                            { event = "lsp", find = "Processing" },
                            { event = "lsp", find = "Indexing" },
                        },
                    },
                    skip = true,
                },
            },
        },
        event = "VeryLazy",
    },
}
