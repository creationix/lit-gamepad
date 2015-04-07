LUAJIT_OS=$(shell luajit -e "print(require('ffi').os)")
LUAJIT_ARCH=$(shell luajit -e "print(require('ffi').arch)")
TARGET_DIR=$(LUAJIT_OS)-$(LUAJIT_ARCH)/

ifeq ($(LUAJIT_OS), OSX)
GAMEPAD_LIB=libgamepad.dylib
else
GAMEPAD_LIB=libgamepad.so
endif

libs: build
	cmake --build build --config Release
	mkdir -p $(TARGET_DIR)
	cp build/$(GAMEPAD_LIB) $(TARGET_DIR)

gamepad/src:
	git submodule update --init gamepad

build: gamepad/src
	cmake -Bbuild -H. -GNinja

gamepad-sample/main.lua:
	git submodule update --init gamepad-sample

gamepad-sample/deps: gamepad-sample/main.lua
	cd gamepad-sample && lit install
	rm -rf gamepad-sample/deps/gamepad
	ln -s ../.. gamepad-sample/deps/gamepad

test: libs gamepad-sample/deps
	LUVI_APP=gamepad-sample lit

clean:
	rm -rf build gamepad-sample/deps
