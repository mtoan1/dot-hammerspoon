local _M = {}

_M.name = "bing_daily_wallpaper"
_M.description = "Use Bing Daily Picture as desktop wallpaper"

local log = hs.logger.new("wallpaper")

-- How many seconds between each Bing request to update the wallpaper:
--   2 minutes: 2 * 60
--   2 hours: 2 * 60 * 60
local do_every_seconds = 1 * 60 * 60

-- It is best to set this according to your screen resolution.
local pic_width, pic_height = 3072, 1920

-- How many days of Bing wallpapers to fetch (one wallpaper per day):
--   Set to 1 to always use the current Bing wallpaper;
--   Set to greater than 1 to randomly choose from recent wallpapers each update.
local pic_count = 1

local pic_save_path = os.getenv("HOME") .. "/.Trash/"

-- API endpoint to get the JSON list of image URLs.
local bing_pictures_url =
    "https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=" ..
    pic_count .. "&nc=1612409408851&pid=hp&FORM=BEHPTB&uhd=1&uhdwidth=" .. pic_width .. "&uhdheight=" .. pic_height

local user_agent_str =
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"

local function curl_callback(exitCode, stdOut, stdErr)
    if exitCode == 0 then
        _M.task = nil
        _M.last_pic = hs.http.urlParts(_M.full_url).query

        local localpath = pic_save_path .. hs.http.urlParts(_M.full_url).query

        -- Set wallpaper for each display (note: not for extra macOS virtual desktops, only for physical displays)
        local screens = hs.screen.allScreens()
        for _, screen in ipairs(screens) do
            log.i(string.format("set wallpaper for %s", screen))
            screen:desktopImageURL("file://" .. localpath)
        end
    else
        log.e(stdOut, stdErr)
    end
end

local function bing_request()
    hs.http.asyncGet(
        bing_pictures_url,
        {["User-Agent"] = user_agent_str},
        function(stat, body, _)
            if stat == 200 then
                if
                    pcall(
                        function()
                            hs.json.decode(body)
                        end
                    )
                 then
                    local decode_data = hs.json.decode(body)
                    local image_urls = decode_data.images
                    local pic_url = image_urls[math.random(1, #image_urls)].url
                    local pic_name = hs.http.urlParts(pic_url).query

                    -- Only set the wallpaper if the new picture is different from the previous one.
                    if _M.last_pic ~= pic_name then
                        _M.full_url = "https://www.bing.com" .. pic_url

                        if _M.task then
                            _M.task:terminate()
                            _M.task = nil
                        end

                        local localpath = pic_save_path .. hs.http.urlParts(_M.full_url).query

                        -- Actually trigger the wallpaper image download here.
                        _M.task =
                            hs.task.new(
                            "/usr/bin/curl",
                            curl_callback,
                            {"-A", user_agent_str, _M.full_url, "-o", localpath}
                        )

                        _M.task:start()

                        log.d("wallpaper changed, current picture: ", pic_name, " last picture: ", _M.last_pic)
                    else
                        log.d("current picture is same as last picture: ", pic_name)
                    end
                end
            else
                log.e("Bing URL request failed!")
            end
        end
    )
end

-- Update wallpaper every time the config is reloaded.
bing_request()

-- Automatically update at regular intervals.
if _M.timer == nil then
    _M.timer =
        hs.timer.doEvery(
        do_every_seconds,
        function()
            bing_request()
        end
    )
else
    _M.timer:start()
end

return _M
