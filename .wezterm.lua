local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

local function addWorkspace()
  wezterm.action.SwitchToWorkspace()
  wezterm.emit("window-config-reloaded")
end

local config = {}
config.debug_key_events = true

config.term = "wezterm"

config.font = wezterm.font("DankMono Nerd Font")
config.font_size = 16.0

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.automatically_reload_config = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.front_end = "WebGpu"
config.webgpu_preferred_adapter = {
  backend = "Metal",
  device = 0,
  device_type = "IntegratedGpu",
  name = "Apple M2 Max",
  vendor = 0,
}

config.leader = { key = "a", mods = "CTRL" }

config.window_padding = {
  left = 0,
  right = 0,
  top = 8,
  bottom = 0,
}

config.keys = {
  {
    key = "r",
    mods = "LEADER",
    action = wezterm.action.ActivateKeyTable({
      name = "resize_pane",
      timeout_milliseconds = 1000,
    }),
  },

  {
    key = "v",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "b",
    mods = "LEADER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "a",
    mods = "LEADER|CTRL",
    action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
  },
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  { key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "LEADER", action = wezterm.action.SwitchToWorkspace },
  { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
  {
    key = "H",
    mods = "ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
  },
  {
    key = "J",
    mods = "ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
  },
  { key = "K", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
  {
    key = "L",
    mods = "ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
  },
  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
  },
  {
    key = "z",
    mods = "LEADER",
    action = wezterm.action.TogglePaneZoomState,
  },
}

return config
