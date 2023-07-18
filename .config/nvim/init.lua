-- Bring in "init.vim" + other packages via vim-plug (must be loaded
-- before loading lazy.nvim)
vim.cmd [[source ~/.config/nvim/setup.vim]]

-- Bootstrap lazy.nvim • https://github.com/folke/lazy.nvim
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

-- Add lazy.nvim packages
require("lazy").setup("plugins", {
  defaults = {
    lazy = false
  }
})
