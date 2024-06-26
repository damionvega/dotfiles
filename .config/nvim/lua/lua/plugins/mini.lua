return { 
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    -- Other mini.<plugin> plugins: https://github.com/echasnovski/mini.nvim
    -- mini.basics
    -- mini.files
    -- mini.indentscope
    -- mini.jump
    -- mini.move
    -- mini.trailspace

    -- surround
    require('mini.surround').setup({
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },

      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = 'cover',

      -- Whether to disable showing non-error feedback
      silent = false,
    })
  end
}

