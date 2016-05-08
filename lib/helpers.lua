local screen = screen
local client = client
local config = config
local awful  = require("awful")

local M = {}


-- Focus helpers

function M.next_client()
  awful.client.focus.byidx(1)
  if client.focus then
    client.focus:raise()
  end
end

function M.prev_client()
  awful.client.focus.byidx(-1)
  if client.focus then
    client.focus:raise()
  end
end

function M.last_client()
  awful.client.focus.history.previous()
  if client.focus then
    client.focus:raise()
  end
end

function M.next_screen()
  awful.screen.focus_relative(1)
end

function M.prev_screen()
  awful.screen.focus_relative(-1)
end


-- Layout manipulation helpers

function M.incmw() awful.tag.incmwfact( 0.05) end
function M.decmw() awful.tag.incmwfact(-0.05) end

function M.incnm() awful.tag.incnmaster( 1) end
function M.decnm() awful.tag.incnmaster(-1) end

function M.incncol() awful.tag.incncol( 1) end
function M.decncol() awful.tag.incncol(-1) end

function M.next_layout() awful.layout.inc(config.layouts,  1) end
function M.prev_layout() awful.layout.inc(config.layouts, -1) end

function M.swap_next() awful.client.swap.byidx( 1) end
function M.swap_prev() awful.client.swap.byidx(-1) end


-- Client helpers

function M.close_window(c) c:kill()  end
function M.raise_window(c) c:raise() end
function M.stick_window(c) c.sticky = not c.sticky end
function M.fullscreen(c)   c.fullscreen = not c.fullscreen end

function M.switch_with_master(c)
  c:swap(awful.client.getmaster())
end

function M.movetoscreen(c)
  if screen.count() == 1 then return nil end
  local s = awful.util.cycle(screen.count(), c.screen + 1)
  if awful.tag.selected(s) then
    c.screen = s
    client.focus = c
    c:raise()
  end
end

function M.maximize(c)
  c.maximized_horizontal = not c.maximized_horizontal
  c.maximized_vertical   = not c.maximized_vertical
  c:raise()
end

function M.toggle_window(c)
  if c == client.focus then
    c.minimized = true
  else
    -- Without this, the following
    -- :isvisible() makes no sense
    c.minimized = false
    if not c:isvisible() then
      awful.tag.viewonly(c:tags()[1])
    end
    -- This will also un-minimize
    -- the client, if needed
    client.focus = c
    c:raise()
  end
end

return M
