-- Catppuccin color scheme for fzf
local colors =
    "bg+:#363a4f," ..
    "bg:#24273a," ..
    "spinner:#f4dbd6," ..
    "hl:#ed8796," ..
    "fg:#cad3f5," ..
    "header:#ed8796," ..
    "info:#c6a0f6," ..
    "pointer:#f4dbd6," ..
    "marker:#f4dbd6," ..
    "fg+:#cad3f5," ..
    "prompt:#c6a0f6," ..
    "hl+:#ed8796"

local M = {
    "ibhagwan/fzf-lua",
    opts = {
        winopts = {
            preview = {
                delay = 0,
            },
            hl = {
                normal = "NormalFloat",
                border = "FloatBorder",
            },
        },
        file_icon_padding = " ",
        fzf_opts = {
            ["--color"] = colors,
        },
    },
    config = function(_, opts)
        require("fzf-lua").setup(opts)
        -- use fzf as the vim.ui.select() function
        require("fzf-lua").register_ui_select()
    end,
    cmd = "FzfLua",
}

M.init = function()
    local function fzf(picker)
        return function()
            require("fzf-lua")[picker]()
        end
    end

    -- find mappings
    vim.keymap.set("n", "<leader>ff", fzf("files"), { desc = "Find files", silent = true })
    vim.keymap.set("n", "<leader>fr", fzf("oldfiles"), { desc = "Find recently opened files", silent = true })
    vim.keymap.set("n", "<leader>fb", fzf("buffers"), { desc = "Find opened buffers", silent = true })

    vim.keymap.set("n", "<leader>fh", fzf("help_tags"), { desc = "Find help pages", silent = true })
    vim.keymap.set("n", "<leader>fm", fzf("man_pages"), { desc = "Find man pages", silent = true })
    vim.keymap.set("n", "<leader>fR", fzf("registers"), { desc = "Find data stored in registers", silent = true })
    vim.keymap.set("n", "<leader>fK", fzf("keymaps"), { desc = "List keymaps", silent = true })

    vim.keymap.set("n", "<leader>fq", fzf("quickfix"), { desc = "Display quickfix", silent = true })
    vim.keymap.set("n", "<leader>fl", fzf("loclist"), { desc = "Display location list", silent = true })

    -- search mappings
    vim.keymap.set("n", "<leader>ss", fzf("grep"), { desc = "Search and put results in quickfix", silent = true })
    vim.keymap.set("n", "<leader>sl", fzf("live_grep_native"), { desc = "Search and put results in location list", silent = true })
    vim.keymap.set("n", "<leader>sr", fzf("grep_last"), { desc = "Search with last pattern", silent = true })
    vim.keymap.set("v", "<leader>ss", fzf("grep_visual"), { desc = "Search with visual selection, silent = true"})
end

return M
