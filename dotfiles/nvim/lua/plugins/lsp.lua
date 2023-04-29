return {
    {
        "neovim/nvim-lspconfig",
        -- dependencies = {
        --     "williamboman/mason.nvim",
        --     "williamboman/mason-lspconfig.nvim",
        -- },
        init = function()
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist)
            vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float)
        end,
        opts = {
            window = {
                border = "rounded",
            },
            diagnostics = {
                virtual_text = false,
                severity_sort = true,
                update_in_insert = false,
                float = {
                    border = "rounded",
                },
            },
            signs = {
                ["DiagnosticSignError"] = "",
                ["DiagnosticSignWarn"] = "",
                ["DiagnosticSignHint"] = "",
                ["DiagnosticSignInfo"] = "",
            },
            icons = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "ﰠ",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Unit = "塞",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "פּ",
                Event = "",
                Operator = "",
                TypeParameter = "",
            },
            servers = {
                ["lua_ls"] = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                            telemetry = {
                                enable = false,
                            },
                        }
                    }
                },
                ["pyright"] = {},
                ["hls"] = {},
                ["texlab"] = {},
            },
            override = {
                handlers = {
                    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
                },
            },
        },
        config = function(_, opts)
            vim.diagnostic.config(opts.diagnostics)

            for name, text in pairs(opts.signs) do
                vim.fn.sign_define(name, {
                    texthl = name,
                    text = text,
                    numhl = "",
                })
            end

            local kinds = vim.lsp.protocol.CompletionItemKind
            for i, kind in pairs(kinds) do
                kinds[i] = opts.icons[kind] or kind
            end

            for server, config in pairs(opts.servers) do
                local cmds = require("lspconfig")[server]
                cmds = cmds.document_config.default_config.cmd

                vim.tbl_extend("force", config, opts.override)

                require("lspconfig.ui.windows").default_options = opts.window

                for _, cmd in ipairs(cmds) do
                    if vim.fn.executable(cmd) == 1 then
                        require("lspconfig")[server].setup(config)
                        break
                    end
                end
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(env)
                    local set_opt = function(...) vim.api.nvim_buf_set_option(env.buf, ...) end
                    set_opt("omnifunc", "v:lua.vim.lsp.omnifunc")
                    set_opt("tagfunc", "v:lua.vim.lsp.tagfunc")
                    set_opt("formatexpr", "v:lua.vim.lsp.formatexpr")

                    local map = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = env.buf }) end
                    map("gd", vim.lsp.buf.definition)
                    map("gD", vim.lsp.buf.declaration)
                    map("<leader>lt", vim.lsp.buf.type_definition)
                    map("<leader>li", vim.lsp.buf.implementation)
                    map("<leader>lr", vim.lsp.buf.references)
                    map("<leader>ll", vim.lsp.buf.hover)
                    map("<leader>ls", vim.lsp.buf.signature_help)
                    map("<leader>la", vim.lsp.buf.code_action)
                    map("<leader>lR", vim.lsp.buf.rename)
                    map("<leader>lf", function()
                        vim.lsp.buf.format({ async = true })
                    end)
                end,
            })
        end,
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "williamboman/mason.nvim",
        enabled = false,
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "",
                    package_pending = "",
                    package_uninstalled = "",
                },
            },
        },
        config = true,
        build = ":MasonUpdate",
        cmd = "Mason",
        keys = {
            { "<leader>m", "<cmd>Mason<CR>", desc = "Open Mason" },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        enabled = false,
        opts = {
            ensure_installed = { "lua_ls" },
            auto_install = true,
        },
        config = true,
    },
}
