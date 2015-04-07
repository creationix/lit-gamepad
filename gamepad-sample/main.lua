local G = require('gamepad')
local uv = require('uv')
local jit = require('jit')

G.Gamepad_init()

for i = 1, G.Gamepad_numDevices() do
  print(G.Gamepad_deviceAtIndex(i - 1))
end

uv.new_timer():start(16, 16, function ()
  G.Gamepad_processEvents()
end)

local function onMove(...)
  p("move", ...)
end
jit.off(onMove)
G.Gamepad_axisMoveFunc(onMove, nil)

local function onDown(...)
  p("down", ...)
end
jit.off(onDown)
G.Gamepad_buttonDownFunc(onDown, nil)

local function onUp(...)
  p("up", ...)
end
jit.off(onUp)
G.Gamepad_buttonUpFunc(onUp, nil)

uv.run()
