@echo off
rem ============================================================
rem  Re-export sprites: puyopuyo.aseprite -> assets/
rem  Just double-click this file after editing the .aseprite!
rem ============================================================
setlocal
set "ASEPRITE=C:\Program Files (x86)\Steam\steamapps\common\Aseprite\aseprite.exe"
cd /d "%~dp0"

if exist "%ASEPRITE%" goto run
echo [ERROR] Aseprite not found at the path in this file.
echo         Edit export.bat and fix the ASEPRITE path.
pause
exit /b 1

:run
echo Exporting with Aseprite...
"%ASEPRITE%" -b --split-layers "puyopuyo.aseprite" --filename-format "{layer}_{frame}" --sheet "assets\puyos.png" --data "assets\puyos.json" --sheet-type packed
if not errorlevel 1 goto convert
echo [ERROR] Export failed.
pause
exit /b 1

:convert
echo Converting JSON to JS (for opening index.html directly)...
powershell -NoProfile -Command "$j = Get-Content -Raw 'assets\puyos.json'; Set-Content -Path 'assets\puyos.js' -Value ('window.PUYO_SHEET_DATA = ' + $j + ';') -Encoding utf8"

echo.
echo Done! Updated: assets\puyos.png / puyos.json / puyos.js
echo Reload the browser to see your new art.
pause
