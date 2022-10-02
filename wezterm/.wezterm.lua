local wezterm = require('wezterm')
local mux = wezterm.mux

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

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
  font_size = 16.0,
  background = {
    {
      source = {
        File = '/Users/fujimotogen/home/Shelf/WallPaper/Pixiv/100960965_p0.jpg',
      },
      width = 'Contain',
      height = 'Contain',
      -- repeat_x = "NoRepeat",
      -- repeat_y = "NoRepeat",
      hsb = { brightness = 0.015 },
      attachment = 'Fixed',
      horizontal_align = 'Center',
      vertical_align = 'Top',
    },
  },
  window_decorations = 'RESIZE', -- "NONE"
  tab_bar_at_bottom = true,
  -- hide_tab_bar_if_only_one_tab = true,
  enable_tab_bar = false,
  color_scheme = 'nordfox',
  default_cwd = '/Users/fujimotogen/home',
  cursor_blink_rate = 0,
  set_environment_variables = {
    TERM = 'wezterm',
  },
  hyperlink_rules = {
    {
      regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
      format = 'https://www.github.com/$1/$3',
    },
  },
}
