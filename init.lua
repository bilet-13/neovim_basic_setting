-- Basic Neovim Settings
vim.opt.number = true               -- Show line numbers
-- vim.opt.relativenumber = true       -- Show relative line numbers
-- vim.opt.expandtab = true            -- Use spaces instead of tabs
-- vim.opt.tabstop = 4                 -- Set tab width to 4 spaces
-- vim.opt.shiftwidth = 4              -- Set indentation width to 4 spaces
vim.opt.smartindent = true          -- Enable smart indentation
vim.opt.termguicolors = true        -- Enable true colors
vim.opt.wrap = true -- Enable line wrapping
vim.opt.clipboard = "unnamedplus"   -- Use system clipboard
vim.opt.cursorline = true           -- Highlight the current line

-- Keybindings
vim.g.mapleader = " "               -- Set leader key to Space
vim.keymap.set("n", "<leader>w", ":w<CR>", { silent = true }) -- Save file
vim.keymap.set("n", "<leader>q", ":q<CR>", { silent = true }) -- Quit file
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })

-- Install lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Setup
require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Syntax highlighting
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- Fuzzy finder
  { "nvim-lualine/lualine.nvim" }, -- Status line
  { "tpope/vim-commentary" }, -- Comment toggle
  { "neovim/nvim-lspconfig" }, -- LSP support
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp" } }, -- Autocomplete
  { "L3MON4D3/LuaSnip" }, -- Snippet support
  { "stevearc/oil.nvim" }, -- file explorer
  { "catppuccin/nvim", as = "catppuccin" },
})

-- theme
vim.cmd.colorscheme("catppuccin")

-- Treesitter Configuration
require("nvim-treesitter.configs").setup {
  ensure_installed = "all",
  highlight = { enable = true },
}

-- Lualine Configuration
require("lualine").setup()

-- oil.nvim Configuration
require("oil").setup({
  default_file_explorer = true, -- Use Oil.nvim instead of netrw
  columns = { "icon" }, -- Show file icons
  keymaps = {
    ["q"] = "actions.close",  -- Quit oil.nvim with 'q'
    ["<CR>"] = "actions.select",  -- Open file
    ["-"] = "actions.parent",  -- Go up one directory
    ["t"] = function()
	local oil = require("oil")
        local entry = oil.get_cursor_entry()
          if entry ~= nil then
	  -- close Oil in current tab
	  oil.close()
          -- Open file in new tab
          vim.cmd.tabnew(entry.name)
          end
        end,  },
  })
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { silent = true }) -- Open file manager

-- Telescope Keybind
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", ":Telescope lsp_references<CR>", { silent = true })

-- LSP Configuration
local lspconfig = require("lspconfig")
lspconfig.pyright.setup {}  -- Python LSP
lspconfig.ts_ls.setup {} -- js
lspconfig.clangd.setup {}   -- C/C++ LSP

-- Autocomplete Configuration
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = { { name = "nvim_lsp" } },
})

-- setting file name and parent as the warp tab name 
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local filepath = vim.fn.expand("%:p") -- Get full file path
    if filepath == "" then
      vim.o.titlestring = "nvim - [No Name]"
      return
    end

    local filename = vim.fn.fnamemodify(filepath, ":t") -- Get only filename
    local parent = vim.fn.fnamemodify(filepath, ":h:t") -- Get parent folder

    vim.cmd("set title") -- Enable title setting
    vim.o.titlestring =  parent .. "/" .. filename
  end,
})
print("Neovim basic config loaded!")

