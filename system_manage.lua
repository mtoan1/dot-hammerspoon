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

return _M
