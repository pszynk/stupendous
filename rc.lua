local naughty = require("naughty")

-- setup path
package.path = package.path .. ";rc/?.lua" .. ";lib/?.lua"

-- user packages
local loader = require("loader")

-- global configuration struct decl
-- root
config = {}

function load_config(lib)
  loader.load_config(config, lib)
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
                   title = "Oops, there were errors during startup!",
                   text = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal(
    "debug::error",
    function (err)
      -- Make sure we don't go into an endless error loop
      if in_error then return end
      in_error = true

      naughty.notify({
          preset = naughty.config.presets.critical,
          title = "Oops, an error happened!",
          text = err })
      in_error = false
  end)
end
-- }}}

--- keys
config.keys = {}
---- modkey
config.keys.modkey = nil --global
config.keys.global = {}
config.keys.client = {}
--- mouse
config.mouse = {}
--- programs
config.prog  = {}
config.prog.term  = nil --global
config.prog.term_cmd  = nil --global
config.prog.editor    = nil --global
config.prog.browser   = nil --global
--- layouts
config.layouts   = {}
--- tags
config.tags = {}
--- misc
config.hostname  = nil --global


-- load global config
load_config("global")

-- load appearance
load_config("appearance")

-- load bindingd
load_config("bindingd")
