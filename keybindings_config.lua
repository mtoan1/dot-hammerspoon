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
		prefix = { "Ctrl", "Option" },
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

return _M
