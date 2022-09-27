local wezterm = require("wezterm")

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

return {
  font = wezterm.font("SFMono Nerd Font"),
  font_size = 16.0,
  ansi = {
    "black",
    "maroon",
    "green",
    "olive",
    "navy",
    "purple",
    "teal",
    "silver",
  },
  brights = {
    "grey",
    "red",
    "lime",
    "yellow",
    "blue",
    "fuchsia",
    "aqua",
    "white",
  },
  window_background_image = "/Users/fujimotogen/home/Shelf/WallPaper/ex2.jpg",
  window_background_image_hsb = {
    -- Darken the background image by reducing it to 1/3rd
    brightness = 0.013,

    -- You can adjust the hue by scaling its value.
    -- a multiplier of 1.0 leaves the value unchanged.
    repeat_x = "Mirror",
    hue = 1.0,
    -- attachment = "Fixed",
    height = 123,

    -- You can adjust the saturation also.
    saturation = 1.0,
  },
  tab_bar_style = {
    active_tab_left = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#2b2042" } },
      { Text = SOLID_LEFT_ARROW },
    }),
    active_tab_right = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#2b2042" } },
      { Text = SOLID_RIGHT_ARROW },
    }),
    inactive_tab_left = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#1b1032" } },
      { Text = SOLID_LEFT_ARROW },
    }),
    inactive_tab_right = wezterm.format({
      { Background = { Color = "#0b0022" } },
      { Foreground = { Color = "#1b1032" } },
      { Text = SOLID_RIGHT_ARROW },
    }),
  },
  window_decorations = "NONE",
  enable_tab_bar = false,
  -- initial_rows = 60,
  -- initial_cols = 300,
  color_scheme = "nightfox",
}
