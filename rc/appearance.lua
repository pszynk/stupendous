-- awesome appearance config

local gears     = require("gears")
local beautiful = require("beautiful")
local naughty   = require("naughty")

local module = {}

local theme = "theme"
local naughty_config = {}
naughty_config.low = {font = "Ubuntu 12", timeput = 5, margin = 10}
naughty_config.normal = naughty_config.low
naughty_config.critical = naughty_config.low

local function setup(...)
  -- Theme
  beautiful.init(context.config_path .. "/" .. theme .. ".lua")

  -- Wallpaper
  if beautiful.wallpaper then
    for s = 1, screen.count() do
      gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
  end

  -- Naughty notify style
  for _,preset in pairs({"normal", "low", "critical"}) do
    naughty.config.presets[preset].font    = naughty_config[preset].font
    naughty.config.presets[preset].timeout = naughty_config[preset].timeout
    naughty.config.presets[preset].margin  = naughty_config[preset].margin
  end
  return true
end

module.setup = setup

return module
