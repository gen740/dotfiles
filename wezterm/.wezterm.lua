local wezterm = require("wezterm")
local mux = wezterm.mux

-- -- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
--
-- -- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

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
  background = {
    {
      source = {
        File = "/Users/fujimotogen/home/Shelf/Pixiv/100960965_p0.jpg",
      },
      -- width = "100%",
      -- height = "100%",
      width = "Contain",
      height = "Contain",
      -- repeat_x = "NoRepeat",
      -- repeat_y = "NoRepeat",
      hsb = { brightness = 0.02 },
      attachment = "Fixed",
      horizontal_align = "Center",
      vertical_align = "Top",
    },
  },
  -- window_decorations = "NONE",
  window_decorations = "RESIZE",
  enable_tab_bar = false,
  -- initial_rows = 65,
  -- initial_cols = 203,
  color_scheme = "nightfox",
  default_cwd = "/Users/fujimotogen/home",
  set_environment_variables = {
    term = "wezterm",
  },
}
