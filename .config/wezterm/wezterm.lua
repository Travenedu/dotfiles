local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- font setting
config.font_size = 15
config.line_height = 1.2
config.font = wezterm.font("JetBrainsMono Nerd Font")

-- Colors
config.colors = {
  cursor_bg = "white",
  cursor_border = "white",
}

-- Appearances
config.window_decorations = "RESIZE | MACOS_FORCE_SQUARE_CORNERS"
config.color_scheme = "Catppuccin Mocha"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right= 0,
  top = 0,
  bottom = 0,
}

-- Miscellaneous settings
config.max_fps = 120
config.prefer_egl = true

return config
