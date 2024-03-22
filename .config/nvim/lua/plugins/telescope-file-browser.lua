return {
  'nvim-telescope/telescope-file-browser.nvim',
  lazy = false,
  config = function()
    -- Default options; not required
    require('telescope').setup({
      extensions = {
        file_browser = {
          theme = 'ivy',
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          -- mappings = {
          --   ["i"] = {
          --     -- your custom insert mode mappings
          --   },
          --   ["n"] = {
          --     -- your custom normal mode mappings
          --   },
          -- },
        },
      },
    })

    -- Call load_extension somewhere after setup function to get
    -- telescope-file-browser loaded and working with telescope
    require('telescope').load_extension 'file_browser'

    -- local builtin = require('telescope.builtin')
    -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    -- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
}
