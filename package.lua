return {
  name = "creationix/gamepad",
  version = "1.0.1",
  homepage = "https://github.com/creationix/lit-gamepad",
  dependencies = {
    "creationix/ffi-loader@1.0.0"
  },
  files = {
    "*.lua",
    "*.h",
    "!gamepad",
    "!test-app",
    "$OS-$ARCH/*",
  }
}
