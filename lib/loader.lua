-- Handle runtime error

-- Notification library
local naughty = require("naughty")

local module = {}


-- require with error notification, end execute setup on config

local function call_setup(lib, config)
  return lib.setup(config)
end

local function load_config(config, ...)
  local status, lib = pcall(require, ...)
  if (status) then
    status, retr = call_setup(lib, config)
    if (status) then
      return retr
    end
  end

  naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, error while loading config file(s) do end!",
      text = "When loading `" .. ... .."`, got the following error:\n" .. status })
  return nil
end

module.load_config = load_config

return module
