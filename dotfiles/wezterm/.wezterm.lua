local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})

    local tab_name_to_tab = {}

    local function spawn_tab(tab_name)
        local tab, _, _ = window:spawn_tab({})
        tab:set_title(tab_name)
        tab_name_to_tab[tab_name] = tab
    end

    spawn_tab("sh")
    spawn_tab("proxy")
    spawn_tab("nvim")
    spawn_tab("k8s")

    for _, tab_name in ipairs({
        "wordsapp",
        "wordsutils",
        "wordslearning",
        "abc-go",
        "wordscollection",
        "svip-go",
        "protos",
        "campaign",
        "deskmate",
        "vocabtest",
        "abtest",
    }) do
        spawn_tab(tab_name)
    end

    tab_name_to_tab["sh"]:activate()
end)

-- config.color_scheme = "catppuccin-latte"
config.color_scheme = "catppuccin-mocha"

config.font = wezterm.font("Iosevka", { weight = "Medium" })
config.font_size = 15.5

config.window_frame = {
    font_size = 14.5,
}

config.enable_tab_bar = true

-- only for nightly
config.show_close_tab_button_in_tabs = false

config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = "Middle" } },
        mods = "NONE",
        action = wezterm.action.Nop,
    },
}
config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Middle" } },
        mods = "NONE",
        action = wezterm.action.Nop,
    },
}

config.leader = { key = "x", mods = "CTRL", timeout_milliseconds = 15000 }

config.keys = {
    -- workspace
    {
        key = "9",
        mods = "ALT",
        action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
    },
    {
        key = "9",
        mods = "CMD",
        action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
    },
    { key = ")", mods = "LEADER", action = act.SwitchWorkspaceRelative(1) },
    { key = "(", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1) },

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

    { key = "Space", mods = "LEADER", action = wezterm.action.ShowTabNavigator },

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
        action = wezterm.action.CloseCurrentPane({ confirm = false }),
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

    {
        key = "o",
        mods = "LEADER",
        action = wezterm.action.ActivateLastTab,
    },

    { key = "{", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "}", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },

    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },

    {
        key = "!",
        mods = "LEADER | SHIFT",
        action = wezterm.action_callback(function(win, pane)
            local tab, window = pane:move_to_new_window()
        end),
    },
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1),
    })
end

wezterm.on("toggle-tabbar", function(window, _)
    local overrides = window:get_config_overrides() or {}
    if overrides.enable_tab_bar == false then
        wezterm.log_info("tab bar shown")
        overrides.enable_tab_bar = true
    else
        wezterm.log_info("tab bar hidden")
        overrides.enable_tab_bar = false
    end
    window:set_config_overrides(overrides)
end)

table.insert(config.keys, { key = "T", mods = "CTRL", action = act.EmitEvent("toggle-tabbar") })

return config
