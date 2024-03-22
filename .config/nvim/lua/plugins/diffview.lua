return {
  'sindrets/diffview.nvim',
  -- commit = '9359f7b1dd3cb9fb1e020f57a91f8547be3558c6', -- HEAD requires git 2.31
  commit = 'HEAD',
  keys = {
    {
      '<C-g>',
      '<CMD>DiffviewOpen<CR>',
      mode = {
        'n',
        'i',
        'v',
      },
    },
  },
  config = {
    keymaps = {
      view = {
        ['<C-g>'] = '<CMD>DiffviewClose<CR>',
        ['c'] = '<CMD>DiffviewClose|Neogit commit<CR>',
      },
      file_panel = {
        ['<C-g>'] = '<CMD>DiffviewClose<CR>',
        ['c'] = '<CMD>DiffviewClose|Neogit commit<CR>',
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'TimUntersberger/neogit',
      config = {
        disable_commit_confirmation = true,
      },
    },
  },
}
