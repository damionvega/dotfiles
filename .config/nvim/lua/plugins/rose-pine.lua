return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  opts = {
    --- @usage 'auto'|'main'|'moon'|'dawn'
    variant = 'dawn',
    --- @usage 'main'|'moon'|'dawn'
    dark_variant = 'moon',
  },
  config = function()
    vim.cmd([[colorscheme rose-pine]])
  end,
}
