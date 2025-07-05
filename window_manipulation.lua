local _M = {}

_M.name = "window_manipulation"
_M.description = "App window management, e.g. move, enlarge, shrink, split screen, etc."

local window_position = require("keybindings_config").window_position
local window_resize = require("keybindings_config").window_resize
local window_batch = require("keybindings_config").window_batch
local window_monitor = require("keybindings_config").window_monitor

local window_lib = require("window_lib")

local log = hs.logger.new("window")

-- ********** window position **********
-- Center
hs.hotkey.bind(
    window_position.center.prefix,
    window_position.center.key,
    window_position.center.message,
    function()
        window_lib.moveAndResize("center")
    end
)
-- Left half of screen
hs.hotkey.bind(
    window_position.left.prefix,
    window_position.left.key,
    window_position.left.message,
    function()
        window_lib.moveAndResize("halfleft")
    end
)
-- Right half of screen
hs.hotkey.bind(
    window_position.right.prefix,
    window_position.right.key,
    window_position.right.message,
    function()
        window_lib.moveAndResize("halfright")
    end
)
-- Upper half of screen
hs.hotkey.bind(
    window_position.up.prefix,
    window_position.up.key,
    window_position.up.message,
    function()
        window_lib.moveAndResize("halfup")
    end
)
-- Lower half of screen
hs.hotkey.bind(
    window_position.down.prefix,
    window_position.down.key,
    window_position.down.message,
    function()
        window_lib.moveAndResize("halfdown")
    end
)
-- Top left corner
hs.hotkey.bind(
    window_position.top_left.prefix,
    window_position.top_left.key,
    window_position.top_left.message,
    function()
        window_lib.moveAndResize("cornerTopLeft")
    end
)
-- Top right corner
hs.hotkey.bind(
    window_position.top_right.prefix,
    window_position.top_right.key,
    window_position.top_right.message,
    function()
        window_lib.moveAndResize("cornerTopRight")
    end
)
-- Bottom left corner
hs.hotkey.bind(
    window_position.bottom_left.prefix,
    window_position.bottom_left.key,
    window_position.bottom_left.message,
    function()
        window_lib.moveAndResize("cornerBottomLeft")
    end
)
-- Bottom right corner
hs.hotkey.bind(
    window_position.bottom_right.prefix,
    window_position.bottom_right.key,
    window_position.bottom_right.message,
    function()
        window_lib.moveAndResize("cornerBottomRight")
    end
)
-- Left 1/3 (landscape) or top 1/3 (portrait)
hs.hotkey.bind(
    window_position.left_1_3.prefix,
    window_position.left_1_3.key,
    window_position.left_1_3.message,
    function()
        window_lib.moveAndResize("left_1_3")
    end
)
-- Right 1/3 (landscape) or bottom 1/3 (portrait)
hs.hotkey.bind(
    window_position.right_1_3.prefix,
    window_position.right_1_3.key,
    window_position.right_1_3.message,
    function()
        window_lib.moveAndResize("right_1_3")
    end
)
-- Left 2/3 (landscape) or top 2/3 (portrait)
hs.hotkey.bind(
    window_position.left_2_3.prefix,
    window_position.left_2_3.key,
    window_position.left_2_3.message,
    function()
        window_lib.moveAndResize("left_2_3")
    end
)
-- Right 2/3 (landscape) or bottom 2/3 (portrait)
hs.hotkey.bind(
    window_position.right_2_3.prefix,
    window_position.right_2_3.key,
    window_position.right_2_3.message,
    function()
        window_lib.moveAndResize("right_2_3")
    end
)
-- 1/3 horizontal, 1/2 vertical at corners
hs.hotkey.bind(
    window_position.top_left_1_3_h_1_2_v.prefix,
    window_position.top_left_1_3_h_1_2_v.key,
    window_position.top_left_1_3_h_1_2_v.message,
    function()
        window_lib.moveAndResize("top_left_1_3_h_1_2_v")
    end
)
hs.hotkey.bind(
    window_position.top_right_1_3_h_1_2_v.prefix,
    window_position.top_right_1_3_h_1_2_v.key,
    window_position.top_right_1_3_h_1_2_v.message,
    function()
        window_lib.moveAndResize("top_right_1_3_h_1_2_v")
    end
)
hs.hotkey.bind(
    window_position.bottom_left_1_3_h_1_2_v.prefix,
    window_position.bottom_left_1_3_h_1_2_v.key,
    window_position.bottom_left_1_3_h_1_2_v.message,
    function()
        window_lib.moveAndResize("bottom_left_1_3_h_1_2_v")
    end
)
hs.hotkey.bind(
    window_position.bottom_right_1_3_h_1_2_v.prefix,
    window_position.bottom_right_1_3_h_1_2_v.key,
    window_position.bottom_right_1_3_h_1_2_v.message,
    function()
        window_lib.moveAndResize("bottom_right_1_3_h_1_2_v")
    end
)

-- ********** window resize **********
-- Maximize
hs.hotkey.bind(
    window_resize.max.prefix,
    window_resize.max.key,
    window_resize.max.message,
    function()
        window_lib.moveAndResize("max")
    end
)
-- Proportionally enlarge window
hs.hotkey.bind(
    window_resize.stretch.prefix,
    window_resize.stretch.key,
    window_resize.stretch.message,
    function()
        window_lib.moveAndResize("stretch")
    end
)
-- Proportionally shrink window
hs.hotkey.bind(
    window_resize.shrink.prefix,
    window_resize.shrink.key,
    window_resize.shrink.message,
    function()
        window_lib.moveAndResize("shrink")
    end
)

-- ********** window monitor **********
-- Move window to above, below, left, right, or next monitor.
hs.hotkey.bind(
    window_monitor.to_above_screen.prefix,
    window_monitor.to_above_screen.key,
    window_monitor.to_above_screen.message,
    function()
        log.d("move to above monitor")
        window_lib.moveToScreen("up")
    end
)
hs.hotkey.bind(
    window_monitor.to_below_screen.prefix,
    window_monitor.to_below_screen.key,
    window_monitor.to_below_screen.message,
    function()
        log.d("move to below monitor")
        window_lib.moveToScreen("down")
    end
)
hs.hotkey.bind(
    window_monitor.to_left_screen.prefix,
    window_monitor.to_left_screen.key,
    window_monitor.to_left_screen.message,
    function()
        log.d("move to left monitor")
        window_lib.moveToScreen("left")
    end
)
hs.hotkey.bind(
    window_monitor.to_right_screen.prefix,
    window_monitor.to_right_screen.key,
    window_monitor.to_right_screen.message,
    function()
        log.d("move to right monitor")
        window_lib.moveToScreen("right")
    end
)
hs.hotkey.bind(
    window_monitor.to_next_screen.prefix,
    window_monitor.to_next_screen.key,
    window_monitor.to_next_screen.message,
    function()
        log.d("move to next monitor")
        window_lib.moveToScreen("next")
    end
)

-- ********** window batch **********
-- Minimize all windows
hs.hotkey.bind(
    window_batch.minimize_all_windows.prefix,
    window_batch.minimize_all_windows.key,
    window_batch.minimize_all_windows.message,
    function()
        log.d("minimized all windows")
        window_lib.minimizeAllWindows()
    end
)
-- Restore all minimized windows
hs.hotkey.bind(
    window_batch.un_minimize_all_windows.prefix,
    window_batch.un_minimize_all_windows.key,
    window_batch.un_minimize_all_windows.message,
    function()
        log.d("unminimize all windows")
        window_lib.unMinimizeAllWindows()
    end
)
-- Close all windows
hs.hotkey.bind(
    window_batch.close_all_windows.prefix,
    window_batch.close_all_windows.key,
    window_batch.close_all_windows.message,
    function()
        log.d("close all windows")
        window_lib.closeAllWindows()
    end
)

return _M
