local _M = {}

_M.name = "keybindings_config"
_M.description = "快捷键配置"

-- 快捷键备忘单展示
_M.keybindings_cheatsheet = {
	prefix = {
		"Option",
	},
	key = "/",
	message = "Toggle Keybindings Cheatsheet",
	description = "⌥/: Toggle Keybindings Cheatsheet",
}

-- 系统管理
_M.system = {
	lock_screen = {
		prefix = { "Option" },
		key = "Q",
		message = "Lock Screen",
	},
}

-- 调用默认浏览器快速打开URL
_M.websites = {
	{
		prefix = { "Option" },
		key = "8",
		message = "github.com",
		target = "https://github.com",
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

-- App
-- NOTE: osascript -e 'id of app "chrome"'
_M.apps = {
	{ prefix = { "Option" }, key = "H", message = "Hammerspoon Console", bundleId = "org.hammerspoon.Hammerspoon" },
	{ prefix = { "Option" }, key = "F", message = "Finder", bundleId = "com.apple.finder" },
	{ prefix = { "Option" }, key = "I", message = "ITerm", bundleId = "com.googlecode.iterm2" },
	{ prefix = { "Option" }, key = "A", message = "ChatWise", bundleId = "app.chatwise" },
	{ prefix = { "Option" }, key = "N", message = "Notion", bundleId = "notion.id" },
	{ prefix = { "Option" }, key = "D", message = "DataGrip", bundleId = "com.jetbrains.datagrip" },
	{ prefix = { "Option" }, key = "K", message = "Freeplane", bundleId = "org.freeplane.launcher" },
	{ prefix = { "Option" }, key = "O", message = "OpenCat", bundleId = "tech.baye.OpenCat" },
	{ prefix = { "Option" }, key = "M", message = "Microsoft Teams", bundleId = "com.microsoft.teams2" },
	{ prefix = { "Option" }, key = "P", message = "Postman", bundleId = "com.postmanlabs.mac" },
	{ prefix = { "Option" }, key = "E", message = "Excel", bundleId = "com.microsoft.Excel" },
	{ prefix = { "Option" }, key = "V", message = "Cursor", bundleId = "com.todesktop.230313mzl4w4u92" },
	{ prefix = { "Option" }, key = "T", message = "Telegram", bundleId = "ru.keepcoder.Telegram" },
	{ prefix = { "Option" }, key = "W", message = "WeChat", bundleId = "com.tencent.xinWeChat" },
	{ prefix = { "Option" }, key = "S", message = "Safari", bundleId = "com.apple.Safari" },
	{ prefix = { "Option" }, key = "G", message = "Goland", bundleId = "com.jetbrains.goland" },
	{ prefix = { "Option" }, key = "C", message = "Google Chrome", bundleId = "com.google.Chrome" },
	{ prefix = { "Option" }, key = "R", message = "OBS", bundleId = "com.obsproject.obs-studio" },
	{ prefix = { "Option" }, key = "L", message = "Lens", bundleId = "com.electron.kontena-lens" },
}

-- 窗口管理: 改变窗口位置
_M.window_position = {
	-- **************************************
	-- 居中
	center = { prefix = { "Ctrl", "Option" }, key = "C", message = "Center Window" },
	-- **************************************
	-- 左半屏
	left = { prefix = { "Ctrl", "Option" }, key = "H", message = "Left Half of Screen" },
	-- 右半屏
	right = { prefix = { "Ctrl", "Option" }, key = "L", message = "Right Half of Screen" },
	-- 上半屏
	up = { prefix = { "Ctrl", "Option" }, key = "K", message = "Up Half of Screen" },
	-- 下半屏
	down = { prefix = { "Ctrl", "Option" }, key = "J", message = "Down Half of Screen" },
	-- **************************************
	-- 左上角
	top_left = { prefix = { "Ctrl", "Option" }, key = "Y", message = "Top Left Corner" },
	-- 右上角
	top_right = { prefix = { "Ctrl", "Option" }, key = "O", message = "Top Right Corner" },
	-- 左下角
	bottom_left = { prefix = { "Ctrl", "Option" }, key = "U", message = "Bottom Left Corner" },
	-- 右下角
	bottom_right = { prefix = { "Ctrl", "Option" }, key = "I", message = "Bottom Right Corner" },
	-- **********************************
	-- 左 1/3（横屏）或上 1/3（竖屏）
	left_1_3 = {
		prefix = { "Ctrl", "Option" },
		key = "Q",
		message = "Left or Top 1/3",
	},
	-- 右 1/3（横屏）或下 1/3（竖屏）
	right_1_3 = {
		prefix = { "Ctrl", "Option" },
		key = "W",
		message = "Right or Bottom 1/3",
	},
	-- 左 2/3（横屏）或上 2/3（竖屏）
	left_2_3 = {
		prefix = { "Ctrl", "Option" },
		key = "E",
		message = "Left or Top 2/3",
	},
	-- 右 2/3（横屏）或下 2/3（竖屏）
	right_2_3 = {
		prefix = { "Ctrl", "Option" },
		key = "R",
		message = "Right or Bottom 2/3",
	},
}

-- 窗口操作: 移动窗口.
_M.window_movement = {
	-- 向上移动窗口
	to_up = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "K",
		message = "Move Upward",
	},
	-- 向下移动窗口
	to_down = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "J",
		message = "Move Downward",
	},
	-- 向左移动窗口
	to_left = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "H",
		message = "Move Leftward",
	},
	-- 向右移动窗口
	to_right = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "L",
		message = "Move Rightward",
	},
}

-- 窗口操作: 改变窗口大小
_M.window_resize = {
	-- 最大化
	max = { prefix = { "Ctrl", "Option" }, key = "M", message = "Max Window" },
	-- 等比例放大窗口
	stretch = { prefix = { "Ctrl", "Option" }, key = "=", message = "Stretch Outward" },
	-- 等比例缩小窗口
	shrink = { prefix = { "Ctrl", "Option" }, key = "-", message = "Shrink Inward" },
	-- 底边向上伸展窗口
	stretch_up = {
		prefix = { "Ctrl", "Option", "Command", "Shift" },
		key = "K",
		message = "Bottom Side Stretch Upward",
	},
	-- 底边向下伸展窗口
	stretch_down = {
		prefix = { "Ctrl", "Option", "Command", "Shift" },
		key = "J",
		message = "Bottom Side Stretch Downward",
	},
	-- 右边向左伸展窗口
	stretch_left = {
		prefix = { "Ctrl", "Option", "Command", "Shift" },
		key = "H",
		message = "Right Side Stretch Leftward",
	},
	-- 右边向右伸展窗口
	stretch_right = {
		prefix = { "Ctrl", "Option", "Command", "Shift" },
		key = "L",
		message = "Right Side Stretch Rightward",
	},
}

-- 窗口管理: 批量处理
_M.window_batch = {
	-- 最小化所有窗口.
	minimize_all_windows = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "M",
		message = "Minimize All Windows",
	},
	-- 恢复所有最小化的窗口.
	un_minimize_all_windows = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "U",
		message = "Unminimize All Windows",
	},
	-- 关闭所有窗口.
	close_all_windows = {
		prefix = { "Ctrl", "Option", "Command" },
		key = "Q",
		message = "Close All Windows",
	},
}

-- 窗口操作: 移动到上下左右或下一个显示器
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
		key = "space", -- 扩展显示器比较少的情况只用这个就可以.
		message = "Move to Next Monitor",
	},
}

return _M
