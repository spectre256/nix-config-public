-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- must be set before lazy is loaded to ensure mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins", {
    defaults = { lazy = true },
    install = {
        colorscheme = { "catppuccin-macchiato" },
    },
    ui = { border = "rounded" },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- load all files in `config` directory safely
for filename, type in vim.fs.dir(vim.fn.stdpath("config") .. "/lua/config") do
    local success, error = pcall(require, "config." .. string.gsub(filename, "%.lua", ""))
    if type == "file" and not success then
        local error_msg = string.format("Could not load `%s` config file:\n%s", filename, error)
        vim.api.nvim_err_writeln(error_msg)
    end
end
