-- Module to manage screen saver and simulate mouse movement
local _M = {}

_M.name = "screen_manager"
_M.description = "Simulates mouse movement and enables screen saver after inactivity"

-- Logger setup
local log = hs.logger.new("screenManager", "info")

-- Configuration
local mouseInterval = 50     -- Simulate mouse movement every 5 seconds
local inactivityTimeout = 600 -- Enable screen saver after 5 minutes
local movementThreshold = 3  -- Pixels to distinguish large (real) mouse movements

-- Mouse simulation state
local mouseTimer = nil
local lastMousePos = hs.mouse.absolutePosition() or {x=0, y=0}

-- Inactivity tracking
local inactivityTimer = nil
local lastActivityTime = os.time()

-- Simulate small mouse movement
local function simulateMouseMovement()
    local pos = hs.mouse.absolutePosition()
    if type(pos) ~= "table" or not pos.x or not pos.y then
        log.e("Invalid mouse position: " .. tostring(pos))
        return
    end
    local newPos = {x = pos.x + 1, y = pos.y + 1}
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.mouseMoved, newPos):post()
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.mouseMoved, pos):post()
    -- log.i("Simulated mouse movement")
    lastMousePos = pos
end

-- Start screen saver
local function startScreenSaver()
    hs.execute("open -a ScreenSaverEngine")
    log.i("Screen saver started")
end

local function lockScreen()
    hs.caffeinate.lockScreen()
    log.i("Screen locked")
end

-- Reset inactivity timer
local function resetInactivityTimer()
    lastActivityTime = os.time()
    if inactivityTimer then
        inactivityTimer:stop()
    end
    inactivityTimer = hs.timer.doAfter(inactivityTimeout, startScreenSaver)
    -- log.i("Inactivity timer reset")
end

-- Event tap callback to detect real user activity
local function eventTapCallback(event)
    local evType = event:getType()
    local isRealActivity = false

    if evType == hs.eventtap.event.types.keyDown or
       evType == hs.eventtap.event.types.leftMouseDown or
       evType == hs.eventtap.event.types.rightMouseDown or
       evType == hs.eventtap.event.types.scrollWheel or 
       evType == hs.eventtap.event.types.gesture then
        isRealActivity = true
    elseif evType == hs.eventtap.event.types.mouseMoved then
        local dx = event:getProperty(hs.eventtap.event.properties.mouseEventDeltaX)
        local dy = event:getProperty(hs.eventtap.event.properties.mouseEventDeltaY)
        local movementSize = math.abs(dx) + math.abs(dy)
        if movementSize > movementThreshold then
            isRealActivity = true
        end
    end

    if isRealActivity then
        -- log.i("Real user activity detected: " .. evType)
        resetInactivityTimer()
    end
    return false -- Pass event through
end

-- Event tap setup
local eventTap = hs.eventtap.new({
    hs.eventtap.event.types.keyDown,
    hs.eventtap.event.types.leftMouseDown,
    hs.eventtap.event.types.rightMouseDown,
    hs.eventtap.event.types.mouseMoved,
    hs.eventtap.event.typesScrollWheel,
    hs.eventtap.event.types.gesture
}, eventTapCallback)

-- Start function
function _M.start()
    -- Start mouse simulation
    mouseTimer = hs.timer.doEvery(mouseInterval, simulateMouseMovement)
    -- Start event monitoring
    eventTap:start()
    -- Initialize inactivity timer
    resetInactivityTimer()
    log.i("Screen manager started")
end

-- Stop function
function _M.stop()
    if mouseTimer then mouseTimer:stop() end
    if inactivityTimer then inactivityTimer:stop() end
    eventTap:stop()
    log.i("Screen manager stopped")
end

return _M