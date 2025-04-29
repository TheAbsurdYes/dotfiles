local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.font_size = 17.5
config.line_height = 1.0

config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_decorations = "RESIZE"

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- config.window_frame = {
--   border_left_width = 0,
--   border_right_width = 0,
--   border_bottom_height = 0,
--   border_top_height = 0,
-- }

config.adjust_window_size_when_changing_font_size = true

config.color_scheme = "Gruber (base16)"

config.max_fps = 120
config.prefer_egl = true

config.keys = {
  {
    key = 'j',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'K',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false

return config
