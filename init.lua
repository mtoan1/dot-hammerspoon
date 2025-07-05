local _M = {}

_M.__index = _M

_M.name = "init"
_M.author = "MT"
_M.license = "MIT"
_M.homepage = "https://github.com/mtoan1/dot-hammerspoon"

-- Hammerspoon Preferences
hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(false)
hs.consoleOnTop(false)
hs.dockIcon(false)
hs.menuIcon(true)
hs.uploadCrashData(false)

-- Duration in seconds to show the hotkey alert message each time a hotkey is pressed; 0 to disable.
hs.hotkey.alertDuration = 0

-- Duration of window animation; set to 0 to disable animation effects.
hs.window.animationDuration = 0

-- Log level for messages printed in the Hammerspoon Console.
-- Options: verbose, debug, info, warning, error, nothing
-- Default: warning
hs.logger.defaultLogLevel = "warning"

-- Quickly launch or switch between apps
require("app_launch")

-- App window operations
require("window_manipulation")

-- System management
require("system_manage")

-- Quick website access
require("website_open")

-- Keep the desktop wallpaper in sync with Bing Daily Picture
require("bing_daily_wallpaper")

-- Show the keybindings cheatsheet panel
require("keybindings_cheatsheet")

-- Keep active
-- require("screen_manager").start()

-- Double modifier remap
require("double_modifier_remap")

-- Automatically reload when lua files change
require("auto_reload")

return _M
