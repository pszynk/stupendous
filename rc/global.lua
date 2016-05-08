
-- Global main config
local module = {}

module.setup = setup

function setup(config)
  config.modkey = "Mod4"
  config.terminal  = "termite"
  config.term_cmd  = config.terminal .. " -e "
  config.hostname  = awful.util.pread('uname -n'):gsub('\n', '')
  config.editor    = os.getenv("EDITOR") or "vim"
  config.browser   = os.getenv("BROWSER") or "chromium"
  return true
end

return module
