local _M = {}

_M.name = "keybindings_cheatsheet"
_M.description = "Display keybindings cheatsheet"

local keybindings_config = require "keybindings_config"
local window_manipulation = require("window_manipulation")
local utf8len = require "utils_lib".utf8len
local utf8sub = require "utils_lib".utf8sub

-- Display settings
local background_opacity = 0.92
local max_line_length = 50
local max_line_number = 30
local line_spacing = 10
local seperator_spacing = 24
local font_name = "Monaco"
local font_size = 16
local font_color = "#f8f8f2"
local stroke_color = "#44475a"
local stroke_width = 2

local focusedWindow = hs.window.focusedWindow()
if focusedWindow == nil then return end
local screen = focusedWindow:screen():frame()
local screen_w, screen_h = screen.w, screen.h
local cooridnate_x = screen_w / 2
local cooridnate_y = screen_h / 2
local num = 0
local canvas = hs.canvas.new({x = 0, y = 0, w = screen_w, h = screen_h})
canvas:appendElements({
    id = "pannel",
    action = "fill",
    fillColor = {alpha = background_opacity, red = 0.09, green = 0.09, blue = 0.13},
    type = "rectangle"
})

local function styleText(text)
    return hs.styledtext.new(
        text,
        {
            font = { name = font_name, size = font_size },
            color = {hex = font_color},
            paragraphStyle = { lineSpacing = line_spacing, alignment = "left" }
        }
    )
end

local function formatKeybinding(prefix, key, message)
    local prefixStr = type(prefix) == "table" and table.concat(prefix, "+") or tostring(prefix)
    return string.format("%s+%s: %s", prefixStr, key, message)
end

local function extractWindowManipulationKeybindings()
    -- Use simple text for each keybinding, similar to PopClip
    local binds = {
        {msg = "Ctrl+Opt+H: Left Half"},
        {msg = "Ctrl+Opt+L: Right Half"},
        {msg = "Ctrl+Opt+J: Left 2/3"},
        {msg = "Ctrl+Opt+K: Right 1/3"},
        {msg = "Ctrl+Opt+I: Top Right 1/3"},
        {msg = "Ctrl+Opt+M: Bottom Right 1/3"},
        {msg = "Ctrl+Opt+Return: Maximize"},
        {msg = "Ctrl+Opt+U: Upper Half"},
        {msg = "Ctrl+Opt+N: Lower Half"},
        {msg = "Ctrl+Opt+C: Center Window"},
        {msg = "Ctrl+Opt+X: Minimize All"},
        {msg = "Ctrl+Opt+Z: Unminimize All"},
    }
    return binds
end

-- Extract PopClip keybindings for cheatsheet
local function extractPopClipKeybindings()
    -- This is a static section for PopClip double Option
    local binds = {
        {msg = "Option+Option: Select All & Activate PopClip"}
    }
    return binds
end

local function formatText()
    local renderText = {}
    local hotkeys = {}
    table.insert(hotkeys, {msg = "[Cheatsheet]"})
    if keybindings_config.keybindings_cheatsheet and keybindings_config.keybindings_cheatsheet.description then
        table.insert(hotkeys, {msg = keybindings_config.keybindings_cheatsheet.description})
    end
    table.insert(hotkeys, {msg = ""})
    for k, v in pairs(keybindings_config) do
        if k == "name" or k == "description" or k == "keybindings_cheatsheet" then goto continue end
        local section = {}
        table.insert(section, {msg = string.format("[%s]", k:gsub("^%l", string.upper):gsub("_", " "))})
        if type(v) == "table" then
            if #v > 0 then
                for _, item in ipairs(v) do
                    if item.prefix and item.key and item.message then
                        table.insert(section, {msg = formatKeybinding(item.prefix, item.key, item.message)})
                    end
                end
            else
                for _, item in pairs(v) do
                    if item.prefix and item.key and item.message then
                        table.insert(section, {msg = formatKeybinding(item.prefix, item.key, item.message)})
                    end
                end
            end
        end
        for _, row in ipairs(section) do table.insert(hotkeys, row) end
        table.insert(hotkeys, {msg = ""})
        ::continue::
    end
    -- Add window_manipulation keybindings
    local wm_binds = extractWindowManipulationKeybindings()
    if #wm_binds > 0 then
        table.insert(hotkeys, {msg = "[Window Manipulation]"})
        for _, row in ipairs(wm_binds) do table.insert(hotkeys, row) end
        table.insert(hotkeys, {msg = ""})
    end
    -- Add PopClip keybindings
    local popclip_binds = extractPopClipKeybindings()
    if #popclip_binds > 0 then
        table.insert(hotkeys, {msg = "[PopClip]"})
        for _, row in ipairs(popclip_binds) do table.insert(hotkeys, row) end
        table.insert(hotkeys, {msg = ""})
    end
    -- Ensure fixed text length
    for _, v in ipairs(hotkeys) do
        num = num + 1
        local msg = v.msg
        local len = utf8len(msg)
        while len > max_line_length do
            local substr = utf8sub(msg, 1, max_line_length)
            table.insert(renderText, {line = substr})
            msg = utf8sub(msg, max_line_length + 1, len)
            len = utf8len(msg)
        end
        for _ = 1, max_line_length - utf8len(msg), 1 do
            msg = msg .. " "
        end
        table.insert(renderText, {line = msg})
    end
    return renderText
end

local function drawText(renderText)
    local columns = 3
    local line_spacing_px = 18
    local padding_x = 32
    local padding_y = 40
    local max_width = screen_w - 2 * padding_x
    local col_width = math.floor(max_width / columns)
    local max_col_height = screen_h - 2 * padding_y
    local max_lines_per_col = math.floor(max_col_height / (font_size + line_spacing_px))
    local total_lines = #renderText
    local show_ellipsis = false
    local lines_in_col = {}
    local idx = 1
    for col = 1, columns do
        lines_in_col[col] = {}
        for row = 1, max_lines_per_col do
            if idx > total_lines then break end
            table.insert(lines_in_col[col], renderText[idx])
            idx = idx + 1
        end
    end
    if idx <= total_lines then
        show_ellipsis = true
    end
    canvas:replaceElements({
        {
            id = "pannel",
            action = "fill",
            fillColor = {alpha = background_opacity, red = 0.09, green = 0.09, blue = 0.13},
            type = "rectangle"
        }
    })
    for col = 1, columns do
        local x = padding_x + (col - 1) * col_width
        local y = padding_y
        for row, v in ipairs(lines_in_col[col]) do
            local itemText = styleText(v.line)
            -- If this is the last visible line in the last column and we are truncating, show ...
            if show_ellipsis and col == columns and row == #lines_in_col[col] then
                itemText = styleText("...")
            end
            canvas:appendElements({
                type = "text",
                text = itemText,
                frame = {
                    x = x,
                    y = y,
                    w = col_width,
                    h = font_size + line_spacing_px
                }
            })
            y = y + font_size + line_spacing_px
        end
    end
    canvas:frame({x = 0, y = 0, w = screen_w, h = screen_h})
end

local show = false
local function toggleKeybindingsCheatsheet()
    if show then
        canvas:hide(.3)
    else
        canvas:show(.3)
    end
    show = not show
end

drawText(formatText())

if keybindings_config.keybindings_cheatsheet then
    hs.hotkey.bind(
        keybindings_config.keybindings_cheatsheet.prefix,
        keybindings_config.keybindings_cheatsheet.key,
        keybindings_config.keybindings_cheatsheet.message,
        toggleKeybindingsCheatsheet
    )
end

return _M
