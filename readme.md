# Neovim Basic Setting with `init.lua`

## TL;DR
git clone the repository:
```bash
git clone "https://github.com/bilet-13/neovim_basic_setting.git"
```
Download Neovim using:
```bash
brew install neovim
```
Copy the `init.lua` file to neovim config folder:
```bash
mkdir -p ~/.config/nvim && cp init.lua ~/.config/nvim/
```
Launch Neovim:
```bash
nvim
```

## Introduction

This repository provides an `init.lua` configuration file to enhance your Neovim experience with better defaults, plugin support, and keybindings.  
By using Lua for configuration instead of Vimscript, this setup improves **performance**, **customizability**, and **plugin management** with `lazy.nvim`.

## Setting Up

To configure Neovim with the provided `init.lua`, follow these steps:

1. **Install Neovim**:  
   ```bash
   brew install neovim
   ```

2. **Set Up Lazy.nvim Plugin Manager**:
   - The configuration uses `lazy.nvim` for managing plugins. The following code in the `init.lua` ensures that `lazy.nvim` is installed:
     ```lua
     local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
     if not vim.loop.fs_stat(lazypath) then
       vim.fn.system({
         "git", "clone", "--filter=blob:none",
         "https://github.com/folke/lazy.nvim.git",
         "--branch=stable", lazypath
       })
     end
     vim.opt.rtp:prepend(lazypath)
     ```

3. **Apply the `init.lua` Configuration**:
   - Replace your existing Neovim configuration with the provided `init.lua` content.  
     On Unix-based systems, this file is typically located at:
     ```bash
     ~/.config/nvim/init.lua
     ```
     On Windows, it can be found at:
     ```bash
     ~/AppData/Local/nvim/init.lua
     ```

4. **Install Plugins**:
   - Upon launching Neovim, `lazy.nvim` will automatically install the specified plugins.
   - If plugins are not installed immediately, run:
     ```vim
     :Lazy sync
     ```

## Features

The `init.lua` configuration enhances Neovim with the following features:

- **Basic Settings**:
  - `vim.opt.number = true`: Displays line numbers.
  - `vim.opt.smartindent = true`: Enables smart indentation.
  - `vim.opt.termguicolors = true`: Enables true color support.
  - `vim.opt.wrap = false`: Disables line wrapping.
  - `vim.opt.clipboard = "unnamedplus"`: Uses the system clipboard.
  - `vim.opt.cursorline = true`: Highlights the current line.

- **Keybindings**:
  - `vim.g.mapleader = " "`: Sets the leader key to Space.
  - `<leader>w`: Saves the current file.
  - `<leader>q`: Quits the current file.
  - `<leader>f`: Opens the file finder using Telescope.
  - `<leader>g`: Performs live grep search using Telescope.
  - `<leader>r`: Finds references using Telescope.
  - `<leader>e`: Opens the file explorer using Oil.nvim.
  - `gr`: Finds references using LSP.

- **Additional Features**:
  - **Enhanced syntax highlighting**: Auto-highlights code for better readability.
  - **Fuzzy search**: Use `Space + f` to quickly find files.
  - **Customizable status line**: Displays file info and cursor position dynamically.
  - **Easy comment toggling**: Press `gc` to comment or uncomment a line.
  - **Language Server Protocol (LSP) support**: Jump to definitions, check references, and get code suggestions.
  - **Tab to autocomplete**: Press `Tab` to cycle through autocomplete suggestions.
  - **Aesthetic color theme**: Automatically applies a modern color scheme for better visual experience.

## Contributing

Feel free to submit a **Pull Request (PR)** to improve this configuration,  
especially if you have suggestions to make it more beginner-friendly for new Neovim users!

