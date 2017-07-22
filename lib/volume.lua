local wibox = require("wibox")
local awful = require("awful")

local M = {}
-- Volume widget

local volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")

local function update_volume(widget)
   local fd = io.popen("amixer sget Master")
   local status = fd:read("*all")
   fd:close()

   local volume = tonumber(string.match(status, "(%d?%d?%d)%%")) / 100
   -- volume = string.format("% 3d", volume)

   status = string.match(status, "%[(o[^%]]*)%]")

   -- starting colour
   local sr, sg, sb = 0x3F, 0x3F, 0x3F
   -- ending colour
   local er, eg, eb = 0xDC, 0xDC, 0xCC

   local ir = math.floor(volume * (er - sr) + sr)
   local ig = math.floor(volume * (eg - sg) + sg)
   local ib = math.floor(volume * (eb - sb) + sb)
   interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)
   if string.find(status, "on", 1, true) then
       volume = " <span background='#" .. interpol_colour .. "'>   </span>"
   else
       volume = " <span color='red' background='#" .. interpol_colour .. "'> M </span>"
   end
   widget:set_markup(volume)
end


local function start_volume_widget()
  update_volume(volume_widget)
  local mytimer = timer({ timeout = 1 })
  mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
  mytimer:start()
end

M.volume_widget = volume_widget
M.start_volme_widget = start_volme_widget

------------------------------------------------------------------------------
-- Handle volume (through pulseaudio)

local naughty  = require("naughty")
local tonumber = tonumber
local string   = string
local config   = config


local lastid  = nil
local channel = "Master"
local _widget = wibox.widget.imagebox()

local function amixer(args)
  local out = awful.util.pread("amixer " .. args)
  local vol, mute = out:match("([%d]+)%%.*%[([%l]*)")
  if not mute or not vol then return end

  vol = tonumber(vol)
  local icon = "high"
  if mute ~= "on" or vol == 0 then
    icon = "muted"
  elseif vol < 30 then
    icon = "low"
  elseif vol < 60 then
    icon = "medium"
  end

  local icon = icons.lookup({name = "audio-volume-" .. icon, type = "status"})
  _widget:set_image(icon)
  lastid = naughty.notify({ text = string.format("%3d %%", vol),
        icon = icon,
        font = "Ubuntu Bold 24",
        replaces_id = lastid }).id
end

function increase()
  amixer("sset " .. channel .. " 5%+")
end

function decrease()
  amixer("sset " .. channel .. " 5%-")
end

function toggle()
  amixer("sset " .. channel .. " toggle")
end

function update()
  amixer("sget " .. channel)
end

function mixer()
  awful.util.spawn(config.term_cmd .. "alsamixer", false)
end

function widget()
  _widget:buttons(awful.util.table.join(
    awful.button({ }, 3, mixer),
    awful.button({ }, 1, toggle),
    awful.button({ }, 4, increase),
    awful.button({ }, 5, decrease)
  ))
  update()
  return _widget
end
