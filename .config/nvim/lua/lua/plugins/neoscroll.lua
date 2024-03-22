return { 
  'karb94/neoscroll.nvim',
  config = function ()
    require('neoscroll').setup({
      easing_function = 'sine',
      pre_hook = function(info) 
        if info == 'cursorline' then
          vim.wo.cursorline = false 
        end
      end,
      post_hook = function(info)
        if info == 'cursorline' then
          vim.wo.cursorline = true 
        end
      end
    })

    local map = {}
    -- Syntax: t[keys] = { function, { function arguments } }
    -- scroll(lines, move_cursor, time[, easing])
    -- zt(half_win_time[, easing])
    map['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '250' } }
    map['<C-d>'] = { 'scroll', {  'vim.wo.scroll', 'true', '250' } }
    map['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '450' } }
    map['<C-f>'] = { 'scroll', {  'vim.api.nvim_win_get_height(0)', 'true', '450' } }
    map['<C-y>'] = { 'scroll', { '-0.20', 'true', '100' } }
    map['<C-e>'] = { 'scroll', {  '0.20', 'true', '100' } }
    map['zt']    = { 'zt', { '250' } }
    map['zz']    = { 'zz', { '250' } }
    map['zb']    = { 'zb', { '250' } }

    require('neoscroll.config').set_mappings(map)
  end,
}
