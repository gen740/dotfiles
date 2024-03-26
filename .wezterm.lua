local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window {}
  window:gui_window():maximize()
end)

local window_padding = 16

return {
  font = wezterm.font_with_fallback {
    {
      family = 'FiraCode Nerd Font',
      -- family = 'HackGen Console NF' &&
    },
    {
      family = 'HackGen Console NF', -- 日本語
      -- sample:
      -- あのイーハトーヴォのすきとおった風、
      -- 夏でも底に冷たさをもつ青いそら、
      -- うつくしい森で飾られたモリーオ市、
      -- 郊外のぎらぎらひかる草の波。
      scale = 1.0,
    },
  },
  color_scheme = 'Tokyo Night',
  font_size = 13,
  window_decorations = 'RESIZE | MACOS_FORCE_DISABLE_SHADOW',
  tab_bar_at_bottom = true,
  enable_tab_bar = false,
  term = 'wezterm',
  ime_preedit_rendering = 'System',
  macos_forward_to_ime_modifier_mask = 'CTRL|SHIFT',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
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
