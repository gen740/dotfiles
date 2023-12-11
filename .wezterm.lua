local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window {}
  window:gui_window():maximize()
end)

return {
  font = wezterm.font_with_fallback {
    {
      family = 'HackGen Console NF',
    },
  },
  default_cursor_style = 'SteadyBlock',
  colors = {
    background = 'rgb(14, 16, 20)',
    cursor_fg = 'black',
    cursor_bg = 'gray',
    compose_cursor = 'gray',
  },
  font_size = 14.0,
  window_decorations = 'RESIZE',
  tab_bar_at_bottom = true,
  enable_tab_bar = false,
  color_scheme = 'nightfox',
  default_cwd = '$HOME/home',
  term = 'wezterm',
  window_padding = {
    left = 24,
    right = 24,
    top = 11,
    bottom = 11,
  },
  keys = {
    { key = '^', mods = 'CTRL|SHIFT', action = wezterm.action { SendString = '\u{1e}' } },
    { key = 'q', mods = 'CTRL', action = wezterm.action { SendString = '\u{11}' } },
  },
  use_ime = true,
}
