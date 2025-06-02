local _M = {}

_M.name = "window_lib"
_M.description = "Window management function library"

-- An integer specifying how many gridparts the screen should be divided into.
-- Defaults to 30.
local gridparts = 30

-- Determine whether the specified screen is vertical
local isVerticalScreen = function(screen)
    if screen:rotate() == 90 or screen:rotate() == 270 then
        return true
    else
        return false
    end
end

-- Move the focused window in the `direction` by on step.
-- Parameters: left, right, up, down
_M.stepMove = function(direction)
    local cwin = hs.window.focusedWindow()
    if cwin then
        local cscreen = cwin:screen()
        local cres = cscreen:fullFrame()
        local stepw = cres.w / gridparts
        local steph = cres.h / gridparts
        local wtopleft = cwin:topLeft()

        if direction == "left" then
            cwin:setTopLeft({x = wtopleft.x - stepw, y = wtopleft.y})
        elseif direction == "right" then
            cwin:setTopLeft({x = wtopleft.x + stepw, y = wtopleft.y})
        elseif direction == "up" then
            cwin:setTopLeft({x = wtopleft.x, y = wtopleft.y - steph})
        elseif direction == "down" then
            cwin:setTopLeft({x = wtopleft.x, y = wtopleft.y + steph})
        end
    else
        hs.alert.show("No focused window!")
    end
end

-- Move and resize the focused window.
-- Parameters:
--   halfleft: left half of screen
--   halfright: right half of screen
--   halfup: upper half of screen
--   halfdown: lower half of screen
--   left_1_3: left or top 1/3
--   right_1_3: right or bottom 1/3
--   left_2_3: left or top 2/3
--   right_2_3: right or bottom 2/3
--   cornerTopLeft: top left corner
--   cornerTopRight: top right corner
--   cornerBottomLeft: bottom left corner
--   cornerBottomRight: bottom right corner
--   max: maximize
--   center: center window with original size
--   stretch: enlarge
--   shrink: shrink
_M.moveAndResize = function(option)
    local cwin = hs.window.focusedWindow()

    if cwin then
        local cscreen = cwin:screen()
        local cres = cscreen:fullFrame()
        local stepw = cres.w / gridparts
        local steph = cres.h / gridparts
        local wf = cwin:frame()

        if option == "halfleft" then
            cwin:setFrame({x = cres.x, y = cres.y, w = cres.w / 2, h = cres.h})
        elseif option == "halfright" then
            cwin:setFrame({x = cres.x + cres.w / 2, y = cres.y, w = cres.w / 2, h = cres.h})
        elseif option == "halfup" then
            cwin:setFrame({x = cres.x, y = cres.y, w = cres.w, h = cres.h / 2})
        elseif option == "halfdown" then
            cwin:setFrame({x = cres.x, y = cres.y + cres.h / 2, w = cres.w, h = cres.h / 2})
        elseif option == "cornerTopLeft" then
            cwin:setFrame({x = cres.x, y = cres.y, w = cres.w / 2, h = cres.h / 2})
        elseif option == "cornerTopRight" then
            cwin:setFrame({x = cres.x + cres.w / 2, y = cres.y, w = cres.w / 2, h = cres.h / 2})
        elseif option == "cornerBottomLeft" then
            cwin:setFrame({x = cres.x, y = cres.y + cres.h / 2, w = cres.w / 2, h = cres.h / 2})
        elseif option == "cornerBottomRight" then
            cwin:setFrame({x = cres.x + cres.w / 2, y = cres.y + cres.h / 2, w = cres.w / 2, h = cres.h / 2})
        elseif option == "max" then
            cwin:setFrame({x = cres.x, y = cres.y, w = cres.w, h = cres.h})
        elseif option == "center" then
            -- cwin:centerOnScreen() centers without changing size,
            -- changed to the following for centering and resizing to proper size.
            cwin:setFrame(
                {
                    x = cres.x + cres.w / 6,
                    y = cres.y + cres.h / 6,
                    w = cres.w / 1.5,
                    h = cres.h / 1.5
                }
            )
        elseif option == "stretch" then
            cwin:setFrame({x = wf.x - stepw, y = wf.y - steph, w = wf.w + (stepw * 2), h = wf.h + (steph * 2)})
        elseif option == "shrink" then
            cwin:setFrame({x = wf.x + stepw, y = wf.y + steph, w = wf.w - (stepw * 2), h = wf.h - (steph * 2)})
        elseif option == "left_1_3" then
            local obj
            if isVerticalScreen(cscreen) then
                obj = {
                    x = cres.x,
                    y = cres.y,
                    w = cres.w,
                    h = cres.h / 3
                }
            else
                obj = {
                    x = cres.x,
                    y = cres.y,
                    w = cres.w / 3,
                    h = cres.h
                }
            end

            cwin:setFrame(obj)
        elseif option == "right_1_3" then
            local obj
            if isVerticalScreen(cscreen) then
                obj = {
                    x = cres.x,
                    y = cres.y + (cres.h / 3 * 2),
                    w = cres.w,
                    h = cres.h / 3
                }
            else
                obj = {
                    x = cres.x + (cres.w / 3 * 2),
                    y = cres.y,
                    w = cres.w / 3,
                    h = cres.h
                }
            end

            cwin:setFrame(obj)
        elseif option == "left_2_3" then
            local obj
            if isVerticalScreen(cscreen) then
                obj = {
                    x = cres.x,
                    y = cres.y,
                    w = cres.w,
                    h = cres.h / 3 * 2
                }
            else
                obj = {
                    x = cres.x,
                    y = cres.y,
                    w = cres.w / 3 * 2,
                    h = cres.h
                }
            end

            cwin:setFrame(obj)
        elseif option == "right_2_3" then
            local obj
            if isVerticalScreen(cscreen) then
                obj = {
                    x = cres.x,
                    y = cres.y + (cres.h / 3),
                    w = cres.w,
                    h = cres.h / 3 * 2
                }
            else
                obj = {
                    x = cres.x + (cres.w / 3),
                    y = cres.y,
                    w = cres.w / 3 * 2,
                    h = cres.h
                }
            end

            cwin:setFrame(obj)
        end
    else
        hs.alert.show("No focused window!")
    end
end

-- Resize the focused window in the `direction` by on step.
-- Parameters: left, right, up, down
_M.directionStepResize = function(direction)
    local cwin = hs.window.focusedWindow()

    if cwin then
        local cscreen = cwin:screen()
        local cres = cscreen:fullFrame()
        local stepw = cres.w / gridparts
        local steph = cres.h / gridparts
        local wsize = cwin:size()

        if direction == "left" then
            cwin:setSize({w = wsize.w - stepw, h = wsize.h})
        elseif direction == "right" then
            cwin:setSize({w = wsize.w + stepw, h = wsize.h})
        elseif direction == "up" then
            cwin:setSize({w = wsize.w, h = wsize.h - steph})
        elseif direction == "down" then
            cwin:setSize({w = wsize.w, h = wsize.h + steph})
        end
    else
        hs.alert.show("No focused window!")
    end
end

-- Move the focused window between all of the screens in the `direction`.
-- Parameters: up, down, left, right, next
_M.moveToScreen = function(direction)
    local cwin = hs.window.focusedWindow()

    if cwin then
        local cscreen = cwin:screen()
        if direction == "up" then
            cwin:moveOneScreenNorth()
        elseif direction == "down" then
            cwin:moveOneScreenSouth()
        elseif direction == "left" then
            cwin:moveOneScreenWest()
        elseif direction == "right" then
            cwin:moveOneScreenEast()
        elseif direction == "next" then
            cwin:moveToScreen(cscreen:next())
        end
    else
        hs.alert.show("No focused window!")
    end
end

-- Minimize all windows.
_M.minimizeAllWindows = function()
    local windows = hs.window.allWindows()

    for _, window in pairs(windows) do
        window:minimize()
    end
end

-- Restore all minimized windows.
_M.unMinimizeAllWindows = function()
    local windows = hs.window.minimizedWindows()

    for _, window in pairs(windows) do
        window:unminimize()
        window:focus()
    end
end

-- Close all windows.
_M.closeAllWindows = function()
    local windows = hs.window.allWindows()

    for _, window in pairs(windows) do
        window:close()
    end
end

return _M
