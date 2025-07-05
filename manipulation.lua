local _M = {}
_M.name        = "window_manipulation"
_M.description = "Quick 3 layouts: split two windows or stack three windows"

local grid      = require("hs.grid")
local hotkey    = require("hs.hotkey")
local window    = require("hs.window")
local alert     = require("hs.alert")

-- Set up a 6×6 grid for window positioning
grid.setGrid("6x6")
grid.MARGINX    = 0
grid.MARGINY    = 0

-- Define modifier keys for shortcuts
local mods = {"ctrl", "option"}

-- Layout definitions with grid coordinates and alert messages
local layouts = {
    -- Equal Halves
    {mods = mods, key = "H", grid = {x=0, y=0, w=3, h=6}, message = "Left Half"},
    {mods = mods, key = "L", grid = {x=3, y=0, w=3, h=6}, message = "Right Half"},
    -- Left 2/3 and Right 1/3 Full Height
    {mods = mods, key = "J", grid = {x=0, y=0, w=4, h=6}, message = "Left 2/3"},
    {mods = mods, key = "K", grid = {x=4, y=0, w=2, h=6}, message = "Right 1/3 Full Height"},
    -- Left 2/3 and Two Stacked Right 1/3
    {mods = mods, key = "I", grid = {x=4, y=0, w=2, h=3}, message = "Top Right 1/3 Width, 1/2 Height"},
    {mods = mods, key = "M", grid = {x=4, y=3, w=2, h=3}, message = "Bottom Right 1/3 Width, 1/2 Height"},
    -- Full Screen
    {mods = mods, key = "return", grid = {x=0, y=0, w=6, h=6}, message = "Full Screen"},
    -- Upper and Lower Half
    {mods = mods, key = "U", grid = {x=0, y=0, w=6, h=3}, message = "Upper Half"},
    {mods = mods, key = "N", grid = {x=0, y=3, w=6, h=3}, message = "Lower Half"},
}

-- Function to apply grid position to the focused window
local function setWindowGrid(gridParams, message)
    local win = window.focusedWindow()
    if win then
        grid.set(win, gridParams, win:screen())
    else
        alert.show("No focused window")
    end
end

-- Bind hotkeys for each layout
for _, layout in ipairs(layouts) do
    hotkey.bind(layout.mods, layout.key, function()
        setWindowGrid(layout.grid, layout.message)
    end)
end

-- Center the focused window
hotkey.bind(mods, "C", function()
    local win = window.focusedWindow()
    if win then
        win:centerOnScreen()
    else
        alert.show("No focused window")
    end
end)


-- Minimize all windows with Control + Option + X
hs.hotkey.bind(mods, "X", function()
    local windows = hs.window.allWindows()
    for _, win in pairs(windows) do
        win:minimize()
    end
end)

-- Unminimize all windows with Control + Option + Z
hs.hotkey.bind(mods, "Z", function()
    local minimizedWindows = hs.window.minimizedWindows()
    for _, win in pairs(minimizedWindows) do
        win:unminimize()
    end
end)

-- Move window to adjacent monitors with arrow keys
local monitorMoves = {
    right = {func = "moveOneScreenEast", label = "Right"},
    left = {func = "moveOneScreenWest", label = "Left"},
    up = {func = "moveOneScreenNorth", label = "Upper"},
    down = {func = "moveOneScreenSouth", label = "Lower"},
}

for key, info in pairs(monitorMoves) do
    hotkey.bind(mods, key, function()
        local win = window.focusedWindow()
        if win then
            win[info.func](win)
        else
            alert.show("No focused window")
        end
    end)
end

return _M