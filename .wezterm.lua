local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

local config = {}
config.debug_key_events = true

config.term = "wezterm"
config.window_close_confirmation = "NeverPrompt"

-- config.font = wezterm.font({
-- 	family = "Berkeley Mono Trial",
-- 	harfbuzz_features = { "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
-- })

config.font_size = 14.0

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.automatically_reload_config = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.front_end = "WebGpu"
local gpu = wezterm.gui.enumerate_gpus()[0]
config.webgpu_preferred_adapter = gpu

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
	{ key = ">", mods = "LEADER", action = wezterm.action.RotatePanes("Clockwise") },
	{ key = "<", mods = "LEADER", action = wezterm.action.RotatePanes("CounterClockwise") },
}

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
	end

	window:set_right_status(wezterm.format({
		{ Text = bat .. "   " .. date },
	}))
end)

return config
