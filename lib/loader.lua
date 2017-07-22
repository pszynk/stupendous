-- Handle runtime error

-- Notification library
local naughty = require("naughty")

local module = {}


-- require with error notification, end execute setup on config

local function requify(...)
  local status, lib = pcall(require, ...)
  if (status) then
    return lib
  end

  naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, error while loading config file(s) do end!",
      text = "When loading `" .. ... .."`, got the following error:\n" .. tostring(lib) })
  return nil
end

module.requify = requify

return module
