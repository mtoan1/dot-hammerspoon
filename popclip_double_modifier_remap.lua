local _M = {}

_M.name = "popclip_double_modifier_remap"
_M.description = "Remaps double presses of specific modifier keys to execute flexible shortcut sequences"
_M.version = "1.0.2" -- Updated version to reflect fix

-- Logger for debugging and error reporting
local log = hs.logger.new("double_modifier", "info")

-- Configuration table for double-press mappings
local keyMappings = {
    {
        prefix = {"alt"}, -- Modifier key
        side = "left", -- "left", "right", or nil (for either)
        threshold = 1, -- Time threshold for double press (seconds)
        actions = {
            {mods = {"cmd"}, key = "A"},
            {mods = {"cmd"}, key = "Q", delay = 0.00001},
        },
        message = "Double Left Command: Cmd+A, Cmd+Q"
    },
    {
        prefix = {"ctrl"}, -- Modifier key
        side = "left", -- "left", "right", or nil (for either)
        threshold = 1, -- Time threshold for double press (seconds)
        actions = {
            {mods = {"alt", "shift"}, key = "up"},
            {mods = {"cmd"}, key = "Q", delay = 0.00001},
        },
        message = "Double Left Control: Alt+Shift+Up, Cmd+Q"
    },
}

-- Key code mappings for modifiers (macOS standard)
local modifierKeyCodes = {
    cmd = {left = 55, right = 54},
    shift = {left = 56, right = 60},
    ctrl = {left = 59, right = 62},
    alt = {left = 58, right = 61}
}

-- Valid modifier flags for validation
local validModifiers = {cmd = true, shift = true, ctrl = true, alt = true, fn = true}

-- Track state for each key-side combination
local keyStates = {}

-- Validate configuration at startup
local function validateConfig()
    for i, mapping in ipairs(keyMappings) do
        -- Validate prefix (single modifier)
        if not mapping.prefix or type(mapping.prefix) ~= "table" or #mapping.prefix ~= 1 then
            log.e(string.format("Invalid prefix in mapping %d; must be a table with one modifier", i))
            return false
        end
        local modifier = mapping.prefix[1]
        if not modifierKeyCodes[modifier] then
            log.e(string.format("Invalid modifier '%s' in mapping %d", tostring(modifier), i))
            return false
        end
        -- Validate side
        if mapping.side and mapping.side ~= "left" and mapping.side ~= "right" then
            log.e(string.format("Invalid side '%s' in mapping %d; must be 'left', 'right', or nil", tostring(mapping.side), i))
            return false
        end
        -- Validate threshold
        if type(mapping.threshold) ~= "number" or mapping.threshold <= 0 then
            log.e(string.format("Invalid threshold '%s' in mapping %d; must be a positive number", tostring(mapping.threshold), i))
            return false
        end
        -- Validate actions
        if not mapping.actions or type(mapping.actions) ~= "table" or #mapping.actions == 0 then
            log.e(string.format("Invalid or empty actions table in mapping %d", i))
            return false
        end
        for j, action in ipairs(mapping.actions) do
            -- Validate modifiers
            if type(action.mods) ~= "table" then
                log.e(string.format("Invalid modifiers table in action %d of mapping %d", j, i))
                return false
            end
            for _, mod in ipairs(action.mods) do
                if not validModifiers[mod] then
                    log.e(string.format("Invalid modifier '%s' in action %d of mapping %d", tostring(mod), j, i))
                    return false
                end
            end
            -- Validate key
            if type(action.key) ~= "string" or not hs.keycodes.map[action.key] then
                log.e(string.format("Invalid key '%s' in action %d of mapping %d", tostring(action.key), j, i))
                return false
            end
            -- Validate delay
            if action.delay and (type(action.delay) ~= "number" or action.delay < 0) then
                log.e(string.format("Invalid delay '%s' in action %d of mapping %d", tostring(action.delay), j, i))
                return false
            end
        end
    end
    return true
end

-- Event tap for detecting modifier key presses
local keyTap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()

    -- Early exit if no mappings
    if not next(keyMappings) then return false end

    for _, mapping in ipairs(keyMappings) do
        local modifier = mapping.prefix[1]
        local keyCodeTable = modifierKeyCodes[modifier]
        if not keyCodeTable then goto continue end

        -- Determine target key code based on side
        local targetKeyCode = mapping.side == "left" and keyCodeTable.left or
                             mapping.side == "right" and keyCodeTable.right or
                             (keyCode == keyCodeTable.left or keyCode == keyCodeTable.right) and keyCode or
                             nil
        if not targetKeyCode or keyCode ~= targetKeyCode then goto continue end

        -- Check if only the target modifier is active
        local isModifierOnly = flags[modifier] and next(flags, modifier) == nil

        if isModifierOnly then
            local stateKey = modifier .. (mapping.side or "either")
            keyStates[stateKey] = keyStates[stateKey] or {pressCount = 0, lastPressTime = 0}

            local currentTime = hs.timer.absoluteTime() / 1000000000
            local timeDiff = currentTime - keyStates[stateKey].lastPressTime

            if timeDiff < mapping.threshold then
                keyStates[stateKey].pressCount = keyStates[stateKey].pressCount + 1
                if keyStates[stateKey].pressCount == 2 then
                    -- log.i(mapping.message)
                    local delay = 0
                    for _, action in ipairs(mapping.actions) do
                        hs.timer.doAfter(delay, function()
                            hs.eventtap.keyStroke(action.mods, action.key)
                        end)
                        delay = delay + (action.delay or 0.05)
                    end
                    keyStates[stateKey].pressCount = 0
                end
            else
                keyStates[stateKey].pressCount = 1
            end
            keyStates[stateKey].lastPressTime = currentTime
        end

        ::continue::
    end

    return false -- Pass through the event
end)

-- Initialize and start the script
function _M.init()
    if not validateConfig() then
        log.e("Configuration validation failed. Event tap not started.")
        hs.alert.show("Double Modifier Remap: Invalid configuration. Check console for details.")
        return
    end

    if not hs.accessibilityState() then
        log.e("Accessibility permissions not granted. Event tap cannot function.")
        hs.alert.show("Double Modifier Remap: Please grant accessibility permissions to Hammerspoon in System Settings > Privacy & Security > Accessibility.")
        return
    end

    keyTap:start()
    log.i("Double Modifier Remap initialized successfully.")
end

-- Cleanup function
function _M.stop()
    keyTap:stop()
    keyStates = {}
    log.i("Double Modifier Remap stopped.")
end

-- Automatically initialize on load
_M.init()

return _M