local opt = vim.opt
local g = vim.g

-- better indentation
opt.autoindent = true
opt.smartindent = true

-- UI settings
opt.cursorline = true
opt.syntax = "on"
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.laststatus = 3
opt.showmode = false
opt.termguicolors = true
g.catppuccin_flavour = "macchiato"
opt.list = true
opt.listchars = { tab = " ", trail = "⋅" } -- eol = "﬋"

-- tab settings
opt.tabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true
opt.smarttab = true

-- padding
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

-- search options
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- default window opening location
opt.splitbelow = true
opt.splitright = true

-- mouse settings
opt.mouse = ""

-- menu options
opt.pumheight = 12

-- don't show certain messages types
opt.shortmess = "aoOsTIcFS"

-- use filetype.lua instead of filetype.vim
g.do_filetype_lua = 1
g.did_load_filetypes = 0
