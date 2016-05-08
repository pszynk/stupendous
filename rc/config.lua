-- main configuration


-- configuration pack
local config = {}

-- modkey
config.modkey = "Mod4"

-- terminal
config.terminal = "termite"

-- editor
config.editor = os.getenv("EDITOR") or "vim"
config.editor_cmd = terminal .. " -e " .. editor

-- browser
config.browser = os.getenv("BROWSER") or "chromium"

-- hostname
config.hostname  = awful.util.pread('uname -n'):gsub('\n', '')

-- Table of layouts to cover with awful.layout.inc, order matters.
config.layouts = {
  awful.layout.suit.floating,           --1
  awful.layout.suit.tile,               --2
  awful.layout.suit.tile.left,          --3
  awful.layout.suit.tile.bottom,        --4
  awful.layout.suit.tile.top,           --5
  awful.layout.suit.fair,               --6
  awful.layout.suit.fair.horizontal,    --7
  awful.layout.suit.spiral,             --8
  awful.layout.suit.spiral.dwindle,     --9
  awful.layout.suit.max,                --10
  awful.layout.suit.max.fullscreen,     --11
  awful.layout.suit.magnifier           --12
}

local awful = require("awful")
local context = {}
context.config_path = awful.util.getdir("config")

return config, context
