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
      family = 'HackGenNerd',
    },
  }),
  default_cursor_style = 'SteadyBlock',
  colors = {
    cursor_fg = 'black',
    cursor_bg = 'gray',
    compose_cursor = 'gray',
  },
  font_size = 18.0,
  -- background = {
  --   {
  --     source = {
  --       -- File = '/Users/fujimotogen/home/Shelf/WallPaper/Pixiv/91012382_p0.jpg',
  --       File = '/Users/fujimotogen/home/Shelf/WallPaper/out/103.jpeg',
  --     },
  --     width = 'Cover',
  --     height = 'Cover',
  --     repeat_x = 'NoRepeat',
  --     repeat_y = 'NoRepeat',
  --     hsb = { brightness = 0.030 },
  --     attachment = 'Fixed',
  --     horizontal_align = 'Center',
  --     vertical_align = 'Middle',
  --   },
  -- },
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
  keys = {
    {
      key = '¥',
      mods = '',
      action = wezterm.action.SendString('\\'),
    },
  },
  hyperlink_rules = {},
  window_padding = {
    left = 24,
    right = 24,
    top = 11,
    bottom = 11,
  },
}
