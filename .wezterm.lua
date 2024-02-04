local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window {}
  window:gui_window():maximize()
end)

local window_padding = 32

return {
  font = wezterm.font_with_fallback {
    {
      family = 'MonaspiceRn Nerd Font',
      harfbuzz_features = {
        'ss01=1',
        'ss02=1',
        'ss03=1',
        'ss04=1',
        'ss05=1',
        'ss06=1',
        'ss07=1',
        'ss08=1',
      },
    },
    {
      family = 'HanziPen SC', -- 日本語
      scale = 1.1,
    },
  },
  color_scheme = 'Tokyo Night',
  font_size = 14.5,
  window_decorations = 'RESIZE | MACOS_FORCE_DISABLE_SHADOW',
  tab_bar_at_bottom = true,
  enable_tab_bar = false,
  term = 'wezterm',
  ime_preedit_rendering = 'System',
  macos_forward_to_ime_modifier_mask = 'CTRL|SHIFT',
  window_padding = {
    left = window_padding,
    right = window_padding,
    top = window_padding,
    bottom = window_padding,
  },
  window_close_confirmation = 'NeverPrompt',
  keys = {
    { key = '^', mods = 'CTRL|SHIFT', action = wezterm.action { SendString = '\u{1e}' } },
    { key = 'q', mods = 'CTRL', action = wezterm.action { SendString = '\u{11}' } },
  },
  use_ime = true,
}
