local wezterm = require('wezterm')
local mux = wezterm.mux

-- -- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
--
-- -- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

return {
  font = wezterm.font_with_fallback({
    {
      family = 'SFMono Nerd Font',
    },
    {
      family = 'HackGen Console NF',
    },
  }),
  default_cursor_style = 'SteadyBlock',
  colors = {
    -- background = 'gray',
    cursor_fg = 'black',
    cursor_bg = 'gray',
    compose_cursor = 'gray',
  },
  font_size = 16.0,
  background = {
    {
      source = {
        -- File = '/Users/fujimotogen/home/Shelf/WallPaper/out/7.jpeg',
        -- File = '/Users/fujimotogen/home/Shelf/WallPaper/out/8.jpeg',
        File = '/Users/fujimotogen/home/Shelf/WallPaper/out/10.jpeg',
      },
      width = 'Cover',
      height = 'Cover',
      repeat_x = 'NoRepeat',
      repeat_y = 'NoRepeat',
      hsb = {
        brightness = 0.015,
        hue = 1.0,
        saturation = 0.6,
      },
      attachment = 'Fixed',
      horizontal_align = 'Center',
      vertical_align = 'Middle',
    },
  },
  window_decorations = 'RESIZE', -- "NONE"
  tab_bar_at_bottom = true,
  -- hide_tab_bar_if_only_one_tab = true,
  enable_tab_bar = false,
  color_scheme = 'nightfox',
  default_cwd = '/Users/fujimotogen/home',
  cursor_blink_rate = 0,
  set_environment_variables = {
    TERM = 'wezterm',
  },
  -- keys = {
  --   {
  --     key = '¥',
  --     mods = '',
  --     action = wezterm.action.SendString('\\'),
  --   },
  -- },
  hyperlink_rules = {},
  -- disable_default_key_bindings = true,
  window_padding = {
    left = 24,
    right = 24,
    top = 11,
    bottom = 11,
  },
  keys = {
    { key = '^', mods = 'CTRL|SHIFT', action = wezterm.action({ SendString = '\u{1e}' }) },
    { key = 'q', mods = 'CTRL', action = wezterm.action({ SendString = '\u{11}' }) },
  },
}
