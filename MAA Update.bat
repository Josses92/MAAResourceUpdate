@echo off
setlocal EnableDelayedExpansion

:: ============================================================
:: SETTINGS FILE LOCATION
:: We store the destination in %LOCALAPPDATA%\MaaAssistant\destination.txt.
:: This folder is usually writable.
:: ============================================================
set "settingsFolder=%LOCALAPPDATA%\MaaAssistant"
if not exist "%settingsFolder%" mkdir "%settingsFolder%"
set "settingsFile=%settingsFolder%\destination.txt"

:: ============================================================
:: LOAD STORED DESTINATION FROM THE SETTINGS FILE
:: ============================================================
if exist "%settingsFile%" (
    for /f "usebackq delims=" %%i in ("%settingsFile%") do set "destination=%%i"
    rem Remove any embedded quotes.
    set "destination=!destination:"=!"
    rem Trim any leading/trailing whitespace using PowerShell.
    for /f "delims=" %%a in ('powershell -NoProfile -Command "Write-Output (\"!destination!\".Trim())"') do set "destination=%%a"
    if "!destination!"=="" (
        echo No stored destination found.
        call :SelectDestination
    ) else if not exist "!destination!" (
        echo Stored destination "!destination!" does not exist.
        call :SelectDestination
    ) else (
        echo Using stored destination: "!destination!"
    )
) else (
    call :SelectDestination
)

:: ============================================================
:: DEFINE TEMPORARY PATHS AND REPOSITORY URL
:: ============================================================
set "zipFile=%TEMP%\MaaResource.zip"
set "extractFolder=%TEMP%\MaaResourceExtracted"
set "repoZipURL=https://github.com/MaaAssistantArknights/MaaResource/archive/refs/heads/main.zip"

:: ============================================================
:: CLEAN UP ANY PREVIOUS TEMPORARY FILES
:: ============================================================
if exist "%zipFile%" del /f /q "%zipFile%"
if exist "%extractFolder%" rmdir /s /q "%extractFolder%"

:: ============================================================
:: DOWNLOAD THE ZIP FILE
:: ============================================================
echo Downloading repository zip...
where curl.exe >nul 2>&1
if %errorlevel%==0 (
    echo Using curl...
    curl -L -o "%zipFile%" "%repoZipURL%"
) else (
    echo curl not found; using PowerShell...
    powershell -NoProfile -Command "Invoke-WebRequest -Uri '%repoZipURL%' -OutFile '%zipFile%'"
)
if errorlevel 1 (
    echo Error: Failed to download repository zip.
    pause
    exit /b 1
)

:: ============================================================
:: EXTRACT THE ZIP FILE USING .NET
:: ============================================================
echo Extracting repository using .NET...
powershell -NoProfile -Command "Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('%zipFile%', '%extractFolder%')"
if errorlevel 1 (
    echo Error: Failed to extract repository zip.
    pause
    exit /b 1
)

:: ============================================================
:: SET THE SOURCE FOLDER (extracted folder)
:: GitHub typically names the folder "MaaResource-main"
:: ============================================================
set "source=%extractFolder%\MaaResource-main"
if not exist "%source%" (
    echo Error: Expected source folder not found: %source%
    pause
    exit /b 1
)

:UpdateAndLaunch
:: Ensure the destination folder exists; if not, force the user to select a valid folder.
if not exist "!destination!" (
    echo Error: Destination folder "!destination!" does not exist.
    call :SelectDestination
    goto UpdateAndLaunch
)

echo Updating local folder...
xcopy /E /Y /I "%source%\*" "!destination!\"
if errorlevel 1 (
    echo Error: Failed to copy files to "!destination!".
    call :SelectDestination
    goto UpdateAndLaunch
)

if not exist "!destination!\MAA.exe" (
    echo Error: MAA.exe not found in "!destination!".
    call :SelectDestination
    goto UpdateAndLaunch
)

echo Update complete.

:: ============================================================
:: CLEAN UP TEMPORARY FILES
:: ============================================================
rmdir /s /q "%extractFolder%"
del /f /q "%zipFile%"

:: ============================================================
:: LAUNCH THE APPLICATION
:: ============================================================
echo Launching MAA.exe...
start "" "!destination!\MAA.exe"
exit /b 0

:SelectDestination
echo.
echo Please select the MAA main folder on your local drive:
for /f "delims=" %%a in ('powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $fbd = New-Object System.Windows.Forms.FolderBrowserDialog; $fbd.Description = 'Select the MAA main folder on your local drive'; if($fbd.ShowDialog() -eq 'OK') { Write-Output $fbd.SelectedPath }"') do set "destination=%%a"
if "!destination!"=="" (
    echo No folder selected. Exiting.
    pause
    exit /b 1
)
rem Remove any embedded quotes.
set "destination=!destination:"=!"
rem Trim any extra whitespace.
for /f "delims=" %%a in ('powershell -NoProfile -Command "Write-Output (\"!destination!\".Trim())"') do set "destination=%%a"
if not exist "!destination!" (
    echo The selected folder "!destination!" does not exist.
    pause
    call :SelectDestination
    exit /b 0
)
echo Selected destination: "!destination!"
rem Save the selected destination (using echo( to avoid extra characters).
> "%settingsFile%" echo(!destination!
exit /b 0
