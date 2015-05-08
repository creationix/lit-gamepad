return {
  name = "creationix/gamepad",
  version = "1.1.1",
  homepage = "https://github.com/creationix/lit-gamepad",
  description = "FFI bindings to cross-platform gamepad library.",
  tags = {"ffi", "gamepad"},
  author = { name = "Tim Caswell" },
  license = "MIT",
  files = {
    "*.lua",
    "*.h",
    "!gamepad",
    "!test-app",
    "$OS-$ARCH/*",
  }
}
