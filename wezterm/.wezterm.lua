local wezterm = require('wezterm')
local mux = wezterm.mux

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
    background = 'rgb(17, 20, 24)',
    cursor_fg = 'black',
    cursor_bg = 'gray',
    compose_cursor = 'gray',
  },
  font_size = 16.0,
  -- background = {
  --   {
  --     source = {
  --       -- File = '/Users/fujimotogen/home/Shelf/WallPaper/out/7.jpeg',
  --       -- File = '/Users/fujimotogen/home/Shelf/WallPaper/out/8.jpeg',
  --       -- File = '/Users/fujimotogen/home/Shelf/WallPaper/out/10.jpeg',
  --       File = '/Users/gen/Documents/Illusts/Pixiv_Following/AndyCHEN_3341779/わため 最高93437389_p0.jpg',
  --     },
  --     width = 'Cover',
  --     height = 'Cover',
  --     repeat_x = 'NoRepeat',
  --     repeat_y = 'NoRepeat',
  --     hsb = {
  --       brightness = 0.016,
  --       hue = 0.7,
  --       saturation = 1.0,
  --     },
  --     attachment = 'Fixed',
  --     horizontal_align = 'Center',
  --     vertical_align = 'Middle',
  --   },
  -- },
  window_decorations = 'RESIZE', -- "NONE"
  tab_bar_at_bottom = true,
  enable_tab_bar = false,
  color_scheme = 'nightfox',
  default_cwd = '$HOME/home',
  term = "wezterm",
  hyperlink_rules = {},
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
