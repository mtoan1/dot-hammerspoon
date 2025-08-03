-- $ luacheck .

std = {
    -- Ignore the check of all built-in variables
    globals = {
        "hs",
        "spoon",
        "io",
        "math",
        "os",
        "require",
        "print",
        "pairs",
        "ipairs",
        "table",
        "next",
        "getmetatable",
        "setmetatable",
        "string",
        "tonumber",
        "tostring",
        "pcall",
        "assert",
        "type",
        "load",
        "error",
        "configWatcher",
        "appWatcher"
    }
}

-- Ignored error types.
ignore = {
    -- Ignore checking code line length.
    "631"
}
