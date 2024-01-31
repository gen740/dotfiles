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
  -- default_cursor_style = 'SteadyBlock',
  color_scheme = 'Tokyo Night',
  font_size = 14.5,
  window_decorations = 'RESIZE | MACOS_FORCE_DISABLE_SHADOW',
  tab_bar_at_bottom = true,
  enable_tab_bar = false,
  term = 'wezterm',
  ime_preedit_rendering = 'System',
  macos_forward_to_ime_modifier_mask = 'CTRL|SHIFT',
  window_padding = {
    left = 48,
    right = 48,
    top = 48,
    bottom = 48,
  },
  window_close_confirmation = 'NeverPrompt',
  keys = {
    { key = '^', mods = 'CTRL|SHIFT', action = wezterm.action { SendString = '\u{1e}' } },
    { key = 'q', mods = 'CTRL', action = wezterm.action { SendString = '\u{11}' } },
  },
  use_ime = true,
}
