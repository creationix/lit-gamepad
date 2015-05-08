
@SET LUAJIT_OS=Windows
@SET LUAJIT_ARCH=x64
@SET TARGET_DIR=%LUAJIT_OS%-%LUAJIT_ARCH%
@SET LIT_PATH=lit.exe
@SET LUVI_PATH=luvi.exe
@SET GAMEPAD_DIR=%~d0%~p0
@SET GAMEPAD_LIB=gamepad.dll

@if not "x%1" == "x" GOTO :%1

:compile
@IF NOT EXIST build CALL make.bat configure
cmake --build build --config Release
COPY build\Release\%BASE_LIB% %TARGET_DIR%\
@GOTO :end

:configure
cmake -Bbuild -H. -G"Visual Studio 12 Win64" -DBUILD_SHARED_LIBS=ON
@GOTO :end

:setup
cd gamepad-sample
%LIT_PATH% install
RMDIR /S /Q deps\gamepad
mklink /j deps\gamepad %GAMEPAD_DIR%
cd ..
@GOTO :end

:test
@CALL make.bat compile
@IF NOT EXIST gamepad-sample\deps CALL make.bat setup
%LUVI_PATH% gamepad-sample
@GOTO :end

:clean
rmdir /S /Q build gamepad-sample\deps
@GOTO :end

:end
