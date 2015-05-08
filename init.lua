local names = {
  ["Windows-x64"] = "gamepad.dll",
  ["Linux-x64"] = "libgamepad.so",
  ["OSX-x64"] = "libgamepad.dylib",
}

local ffi = require('ffi')
ffi.cdef(module:load("gamepad.h"))

local arch = ffi.os .. "-" .. ffi.arch
return module:action(arch .. "/" .. names[arch], function (path)
  return ffi.load(path)
end)
