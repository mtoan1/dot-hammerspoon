local _M = {}

_M.name = "keybindings_config"
_M.description = "Keybinding configuration"

-- Keybindings cheatsheet display
_M.keybindings_cheatsheet = {
	prefix = {
		"Option",
	},
	key = "/",
	message = "Toggle Keybindings Cheatsheet",
	description = "⌥/: Toggle Keybindings Cheatsheet",
}

-- System management
_M.system = {
	lock_screen = {
		prefix = { "Option" },
		key = "Q",
		message = "Lock Screen",
	},
}

-- Quickly open URL using default browser
_M.websites = {
	{
		prefix = { "Option" },
		key = "8",
		message = "github.com",
		target = "https://github.com/windvalley",
	},
	{
		prefix = { "Option" },
		key = "9",
		message = "google.com",
		target = "https://www.google.com",
	},
	{
		prefix = { "Option" },
		key = "7",
		message = "bing.com",
		target = "https://www.bing.com",
	},
}


-- App launch or hide
-- NOTE: Example to get an app's bundleId: osascript -e 'id of app "chrome"'
_M.apps = {
	{ prefix = { "Option" }, key = "H", message = "Hammerspoon Console", bundleId = "org.hammerspoon.Hammerspoon" },
	{ prefix = { "Option" }, key = "F", message = "Finder", bundleId = "com.apple.finder" },
	{ prefix = { "Option" }, key = "I", message = "ITerm", bundleId = "com.googlecode.iterm2" },
	{ prefix = { "Option" }, key = "A", message = "ChatWise", bundleId = "app.chatwise" },
	{ prefix = { "Option" }, key = "N", message = "Notion", bundleId = "notion.id" },
	{ prefix = { "Option" }, key = "D", message = "Dia", bundleId = "company.thebrowser.dia" },
	{ prefix = { "Option" }, key = "K", message = "DataGrip", bundleId = "com.jetbrains.datagrip" },
	{ prefix = { "Option" }, key = "O", message = "OpenCat", bundleId = "tech.baye.OpenCat" },
	{ prefix = { "Option" }, key = "M", message = "Microsoft Teams", bundleId = "com.microsoft.teams2" },
	{ prefix = { "Option" }, key = "P", message = "Postman", bundleId = "com.postmanlabs.mac" },
	-- { prefix = { "Option" }, key = "E", message = "Plain Text Editor", bundleId = "com.sindresorhus.Plain-Text-Editor" },
	{ prefix = { "Option" }, key = "V", message = "VSCode", bundleId = "com.microsoft.VSCode" },
	{ prefix = { "Option" }, key = "T", message = "Telegram", bundleId = "ru.keepcoder.Telegram" },
	-- { prefix = { "Option" }, key = "W", message = "WeChat", bundleId = "com.tencent.xinWeChat" },
	{ prefix = { "Option" }, key = "S", message = "Safari", bundleId = "com.apple.Safari" },
	{ prefix = { "Option" }, key = "G", message = "Goland", bundleId = "com.jetbrains.goland" },
	{ prefix = { "Option" }, key = "C", message = "Google Chrome", bundleId = "com.google.Chrome" },
	-- { prefix = { "Option" }, key = "R", message = "OBS", bundleId = "com.obsproject.obs-studio" },
	-- { prefix = { "Option" }, key = "L", message = "Lens", bundleId = "com.electron.kontena-lens" },
}

-- Window management: change window position
_M.window_position = {
	-- **************************************
	-- Center
	center = { prefix = { "Ctrl", "Option" }, key = "C", message = "Center Window" },
	-- **************************************
	-- Left half of screen
	left = { prefix = { "Ctrl", "Option" }, key = "H", message = "Left Half of Screen" },
	-- Right half of screen
	right = { prefix = { "Ctrl", "Option" }, key = "L", message = "Right Half of Screen" },
	-- Upper half of screen
	up = { prefix = { "Ctrl", "Option" }, key = "K", message = "Up Half of Screen" },
	-- Lower half of screen
	down = { prefix = { "Ctrl", "Option" }, key = "J", message = "Down Half of Screen" },
	-- **************************************
	-- Top left corner
	top_left = { prefix = { "Ctrl", "Option" }, key = "Y", message = "Top Left Corner" },
	-- Top right corner
	top_right = { prefix = { "Ctrl", "Option" }, key = "O", message = "Top Right Corner" },
	-- Bottom left corner
	bottom_left = { prefix = { "Ctrl", "Option" }, key = "U", message = "Bottom Left Corner" },
	-- Bottom right corner
	bottom_right = { prefix = { "Ctrl", "Option" }, key = "I", message = "Bottom Right Corner" },
	-- **********************************
	-- Left 1/3 (landscape) or top 1/3 (portrait)
	left_1_3 = {
		prefix = { "Ctrl", "Option" },
		key = "Q",
		message = "Left or Top 1/3",
	},
	-- Right 1/3 (landscape) or bottom 1/3 (portrait)
	right_1_3 = {
		prefix = { "Ctrl", "Option" },
		key = "W",
		message = "Right or Bottom 1/3",
	},
	-- Left 2/3 (landscape) or top 2/3 (portrait)
	left_2_3 = {
		prefix = { "Ctrl", "Option" },
		key = "E",
		message = "Left or Top 2/3",
	},
	-- Right 2/3 (landscape) or bottom 2/3 (portrait)
	right_2_3 = {
		prefix = { "Ctrl", "Option" },
		key = "R",
		message = "Right or Bottom 2/3",
	},
}

-- Window operation: move window.
_M.window_movement = {
	-- Move window upward
	to_up = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "K",
		message = "Move Upward",
	},
	-- Move window downward
	to_down = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "J",
		message = "Move Downward",
	},
	-- Move window to the left
	to_left = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "H",
		message = "Move Leftward",
	},
	-- Move window to the right
	to_right = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "L",
		message = "Move Rightward",
	},
}

-- Window operation: change window size
_M.window_resize = {
	-- Maximize
	max = { prefix = { "Ctrl", "Option" }, key = "M", message = "Max Window" },
	-- Proportionally enlarge window
	stretch = { prefix = { "Ctrl", "Option" }, key = "=", message = "Stretch Outward" },
	-- Proportionally shrink window
	shrink = { prefix = { "Ctrl", "Option" }, key = "-", message = "Shrink Inward" },
	-- Stretch bottom edge of window upward
	stretch_up = {
		prefix = { "Ctrl", "Option", "Command", "Shift" },
		key = "K",
		message = "Bottom Side Stretch Upward",
	},
	-- Stretch bottom edge of window downward
	stretch_down = {
		prefix = { "Ctrl", "Option", "Command", "Shift" },
		key = "J",
		message = "Bottom Side Stretch Downward",
	},
	-- Stretch right edge of window to the left
	stretch_left = {
		prefix = { "Ctrl", "Option", "Command", "Shift" },
		key = "H",
		message = "Right Side Stretch Leftward",
	},
	-- Stretch right edge of window to the right
	stretch_right = {
		prefix = { "Ctrl", "Option", "Command", "Shift" },
		key = "L",
		message = "Right Side Stretch Rightward",
	},
}

-- Window management: batch processing
_M.window_batch = {
	-- Minimize all windows.
	minimize_all_windows = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "M",
		message = "Minimize All Windows",
	},
	-- Restore all minimized windows.
	un_minimize_all_windows = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "U",
		message = "Unminimize All Windows",
	},
	-- Close all windows.
	close_all_windows = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "Q",
		message = "Close All Windows",
	},
}

-- Window operation: move to above, below, left, right, or next monitor
_M.window_monitor = {
	to_above_screen = {
		prefix = { "Ctrl", "Option" },
		key = "up",
		message = "Move to Above Monitor",
	},
	to_below_screen = {
		prefix = { "Ctrl", "Option" },
		key = "down",
		message = "Move to Below Monitor",
	},
	to_left_screen = {
		prefix = { "Ctrl", "Option" },
		key = "left",
		message = "Move to Left Monitor",
	},
	to_right_screen = {
		prefix = { "Ctrl", "Option" },
		key = "right",
		message = "Move to Right Monitor",
	},
	to_next_screen = {
		prefix = { "Ctrl", "Option" },
		key = "space", -- If you have few external monitors, just use this.
		message = "Move to Next Monitor",
	},
}

return _M
