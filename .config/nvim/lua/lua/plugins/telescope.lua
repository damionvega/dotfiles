return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  tag = '0.1.2',
  keys = {
    { "<C-t>", "<CMD>Telescope<CR>", mode = { "n", "i", "v" } },
    { "<C-o>", "<CMD>Telescope find_files<CR>", mode = { "n", "i", "v" } },
    { "<C-p>", "<CMD>Telescope live_grep<CR>", mode = { "n", "i", "v" } },
    { "<C-c>", "<CMD>Telescope commands<CR>", mode = { "n", "i", "v" } },
    { "<C-m>", "<CMD>Telescope keymaps<CR>", mode = { "n", "i", "v" } },
  },
  dependencies = {
    'nvim-lua/plenary.nvim' 
  }
}

