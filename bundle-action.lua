-- Proposed addition to bundle API in luvi
local bundle = require('luvi').bundle
local pathJoin = require('luvi').path.join
local env = require('env')
local uv = require('uv')
local os = require('ffi').os

local tmpBase = os == "Windows" and (env.get("TMP") or uv.cwd()) or
                                    (env.get("TMPDIR") or '/tmp')

function bundle.action(path, action)
  -- If it's a real path, run it directly.
  if uv.fs_access(path, "r") then return action(path) end
  -- Otherwise, copy to a temporary folder and run from there
  local data, err = bundle.readfile(path)
  if not data then return nil, err end
  local dir = assert(uv.fs_mkdtemp(pathJoin(tmpBase, "lib-XXXXXX")))
  path = pathJoin(dir, path:match("[^/\\]+$"))
  local fd = uv.fs_open(path, "w", 384) -- 0600
  uv.fs_write(fd, data, 0)
  uv.fs_close(fd)
  local success, ret = pcall(action, path)
  uv.fs_unlink(path)
  uv.fs_rmdir(dir)
  assert(success, ret)
  return ret
end

