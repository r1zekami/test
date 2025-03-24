@echo off
setlocal enabledelayedexpansion

set "ROOT_DIR=%~dp0"

echo Downloading get_ps_servers.bat...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/r1zekami/test/refs/heads/main/get_ps_servers.bat' -OutFile 'get_ps_servers.bat' -UseBasicParsing"
if %ERRORLEVEL% neq 0 (
    echo Failed to download get_ps_servers.bat
    exit /b 1
)

echo Running get_ps_servers.bat...
call get_ps_servers.bat
if %ERRORLEVEL% neq 0 (
    echo Error in get_ps_servers.bat
    exit /b 1
)


echo Running setup.bat...
cd "%ROOT_DIR%SignallingWebServer\platform_scripts\cmd"
call setup.bat
if %ERRORLEVEL% neq 0 (
    echo Error in setup.bat
    exit /b 1
)



echo Updating config.json...
set "CONFIG_PATH=%ROOT_DIR%SignallingWebServer\config.json"
(
    echo {
    echo     "UseFrontend": false,
    echo     "UseMatchmaker": false,
    echo     "UseHTTPS": false,
    echo     "LogToFile": true,
    echo     "LogVerbose": true,
    echo     "HomepageFile": "uiless.html",
    echo     "AdditionalRoutes": {},
    echo     "EnableWebserver": true,
    echo     "MatchmakerAddress": "",
    echo     "MatchmakerPort": 9999,
    echo     "PublicIp": "0.0.0.0",
    echo     "HttpPort": 80,
    echo     "HttpsPort": 443,
    echo     "StreamerPort": 8888,
    echo     "SFUPort": 8889,
    echo     "MaxPlayerCount": -1
    echo }
) > "%CONFIG_PATH%"


echo Cleaning Public directory...
cd "%ROOT_DIR%SignallingWebServer\Public"
del uiless.html uiless.js /Q 2>nul


echo Downloading icon.png...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/r1zekami/test/refs/heads/main/icon.png' -OutFile 'icon.png' -UseBasicParsing"
if %ERRORLEVEL% neq 0 (
    echo Failed to download icon.png
    exit /b 1
)
        
echo Downloading uiless.js...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/r1zekami/test/refs/heads/main/uiless.js' -OutFile 'uiless.js' -UseBasicParsing"
if %ERRORLEVEL% neq 0 (
    echo Failed to download uiless.js
    exit /b 1
)

echo Downloading uiless.html...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/r1zekami/test/refs/heads/main/uiless.html' -OutFile 'uiless.html' -UseBasicParsing"
if %ERRORLEVEL% neq 0 (
    echo Failed to download uiless.html
    exit /b 1
)




echo All operations completed successfully!
echo .
echo .
echo cd SignallingWebServer\platform_scripts\cmd\
echo SignallingWebServer\platform_scripts\cmd\run_local.bat
echo .
echo .

endlocal
