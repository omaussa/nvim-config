local status, theme = pcall(require, 'tokyonight')
if (not status) then return end

theme.setup {
  --transparent = true,
  transparent_sidebar = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    constants = { italic = true },
  }
}

vim.cmd[[colorscheme tokyonight]]
