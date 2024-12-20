local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "catppuccin-latte"

config.font = wezterm.font("Iosevka", { weight = "Medium" })
config.font_size = 15.5

config.window_frame = {
	font_size = 14.5,
}

config.enable_tab_bar = true

config.leader = { key = "x", mods = "CTRL", timeout_milliseconds = 15000 }

config.keys = {
	-- https://github.com/wez/wezterm/issues/522
	{
		key = "E",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	{ key = "F9", action = wezterm.action.ShowTabNavigator },

	{ key = "r", mods = "ALT", action = act.ActivateWindowRelative(1) },
	{ key = "e", mods = "ALT", action = act.ActivateWindowRelative(-1) },
	{ key = "r", mods = "CMD", action = act.ActivateWindowRelative(1) },
	{ key = "e", mods = "CMD", action = act.ActivateWindowRelative(-1) },

	{
		key = "b",
		mods = "CMD",
		action = wezterm.action.SendKey({ key = "b", mods = "ALT" }),
	},
	{
		key = "f",
		mods = "CMD",
		action = wezterm.action.SendKey({ key = "f", mods = "ALT" }),
	},
	{
		key = "Backspace",
		mods = "CMD",
		action = wezterm.action.SendKey({ key = "Backspace", mods = "ALT" }),
	},
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SendKey({ key = "d", mods = "ALT" }),
	},

	-- panel
	{
		key = '"',
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "%",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- tab
	{ key = "c", mods = "LEADER", action = act.SpawnTab("DefaultDomain") },
	{ key = "&", mods = "LEADER", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
}

return config
