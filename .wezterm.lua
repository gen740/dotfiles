local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window {}
  window:gui_window():maximize()
end)

return {
  font = wezterm.font_with_fallback {
    {
      -- family = 'SFMono Nerd Font',
      -- family = 'BigBlueTerm437 Nerd Font',
      -- family = 'Tinos Nerd Font',
      -- family = 'ProggyClean Nerd Font',
      -- family = 'Hack Nerd Font Mono',
      -- family = 'HackGen Console NF',
      family = 'M+1Code Nerd Font',
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
  window_decorations = 'RESIZE | MACOS_FORCE_DISABLE_SHADOW',
  tab_bar_at_bottom = true,
  enable_tab_bar = false,
  color_scheme = 'nightfox',
  default_cwd = '$HOME/home',
  term = 'wezterm',
  ime_preedit_rendering = 'System',
  macos_forward_to_ime_modifier_mask = 'CTRL|SHIFT',
  window_padding = {
    left = 6,
    right = 6,
    top = 6,
    bottom = 6,
  },
  keys = {
    { key = '^', mods = 'CTRL|SHIFT', action = wezterm.action { SendString = '\u{1e}' } },
    { key = 'q', mods = 'CTRL', action = wezterm.action { SendString = '\u{11}' } },
  },
  use_ime = true,
}