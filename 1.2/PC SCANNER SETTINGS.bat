@echo off
title PC Scanner Settings

:Menu
cls
echo ==============================
echo         PC Scanner Settings
echo ==============================
echo 1. Open Settings
echo 2. Close
echo ==============================
choice /c 12 /n /t 10 /d 2 /m "Choose an option:"
if errorlevel 2 goto TerminatingMenu
if errorlevel 1 goto SettingsMenu

:SettingsMenu
cls
echo ==============================
echo     PC Scanner Settings
echo ==============================
echo 1. Delete PC Scanner
echo 2. Open GitHub
echo 3. Return to Home
echo ==============================
choice /c 123 /n /m "Choose an option:"
if errorlevel 3 goto Menu
if errorlevel 2 goto OpenGitHub
if errorlevel 1 goto DeletePCScanner

:DeletePCScanner
cls
echo Searching for PC Scanner.vbs across the entire computer...
timeout /t 2 >nul

:: Search the entire computer
set fileFound=0
for /r %%i in ("PC Scanner.vbs") do (
    set fileFound=1
    set filePath=%%i
)

if %fileFound%==1 (
    echo PC Scanner.vbs found at "%filePath%".
    echo This will delete all PC Scanner-related files installed at the same timestamp.
    echo Warning: Our system may affect your PC. You can manually delete the files if you prefer.
    echo.
    echo 1. Delete files
    echo 2. Delete manually
    choice /c 12 /n /m "Choose an option:"
    if errorlevel 2 goto OpenPCScannerLocation
    if errorlevel 1 (
        echo Deleting related files...
        for %%j in ("%filePath%") do (
            set "timestamp=%%~tj"
        )
        for /r %%k in (*) do (
            if "%%~tk"=="%timestamp%" del /q "%%k"
        )
        cls
        echo Files deleted successfully.
        timeout /t 2 >nul
        goto TerminatingMenu
    )
) else (
    echo PC Scanner.vbs not found. Returning to settings.
    timeout /t 2 >nul
    goto SettingsMenu
)

:OpenPCScannerLocation
cls
echo Opening PC Scanner.vbs location...
start "" "%filePath%"
timeout /t 2 >nul
goto SettingsMenu

:OpenGitHub
cls
echo Warning: This option will open a browser.
choice /c YN /n /m "Do you want to continue? (Y/N)"
if errorlevel 2 goto SettingsMenu
if errorlevel 1 (
    start "" "https://github.com/freetechdownloads/pcscanner"
    goto SettingsMenu
)

:TerminatingMenu
cls
title PC Scanner Settings
echo ==============================
echo      Terminating Options        
echo ==============================
echo.
echo Press 0 to close immediately.
echo Press 1 to cancel and return to home.
choice /c 01 /n >nul
if errorlevel 2 goto Menu
if errorlevel 1 exit
