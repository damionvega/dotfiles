return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  branch = '0.1.4',
  keys = {
    { '<C-t>', '<CMD>Telescope<CR>', mode = { 'n', 'i', 'v' }, },
    { '<C-f>', '<CMD>Telescope find_files<CR>', mode = { 'n', 'i', 'v' }, },
    { '<C-g>', '<CMD>Telescope live_grep<CR>', mode = { 'n', 'i', 'v' }, },
    { '<C-n>', '<CMD>Telescope commands<CR>', mode = { 'n', 'i', 'v' }, },
    { '<C-m>', '<CMD>Telescope keymaps<CR>', mode = { 'n', 'i', 'v' }, },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}

