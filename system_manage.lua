local _M = {}

_M.name = "system_manage"
_M.description = "System management, e.g.: lock screen, start screensaver, restart, etc."

local system = require("keybindings_config").system

local log = hs.logger.new("system")

-- Lock screen.
hs.hotkey.bind(
    system.lock_screen.prefix,
    system.lock_screen.key,
    system.lock_screen.message,
    function()
        log.d("lock screen")
        hs.caffeinate.lockScreen()
    end
)

-- Start screensaver.
hs.hotkey.bind(
    system.screen_saver.prefix,
    system.screen_saver.key,
    system.screen_saver.message,
    function()
        log.d("start screensaver")
        hs.caffeinate.startScreensaver()
    end
)

-- Restart.
hs.hotkey.bind(
    system.restart.prefix,
    system.restart.key,
    system.restart.message,
    function()
        hs.caffeinate.restartSystem()
    end
)

-- Shutdown.
hs.hotkey.bind(
    system.shutdown.prefix,
    system.shutdown.key,
    system.shutdown.message,
    function()
        hs.caffeinate.shutdownSystem()
    end
)

return _M
