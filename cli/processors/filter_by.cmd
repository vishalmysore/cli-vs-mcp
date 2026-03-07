@echo off
REM Processor: Filter data by criteria (reads from temp file)
REM Usage: filter_by.cmd <input_file> <field> <operator> <value>
setlocal enabledelayedexpansion

set INPUT_FILE=%~1
set FIELD=%~2
set OPERATOR=%~3
set VALUE=%~4

if "%INPUT_FILE%"=="" (
    echo [CLI-PROCESSOR] Error: Missing input file parameter
    exit /b 1
)

if "%FIELD%"=="" (
    echo [CLI-PROCESSOR] Error: Missing field parameter
    exit /b 1
)

echo [CLI-PROCESSOR] Filtering by %FIELD% %OPERATOR% %VALUE%
echo.

REM Read from input file - use "delims=" to preserve pipe characters
set "FIRST_LINE=true"
for /f "usebackq tokens=* delims=" %%a in ("%INPUT_FILE%") do (
    set "line=%%a"
    
    REM Print header line
    if !FIRST_LINE!==true (
        echo !line!
        set "FIRST_LINE=false"
    ) else (
        REM Simple filtering logic based on field position
        if "%FIELD%"=="TIER" (
            echo !line! | findstr /i "%VALUE%" >nul
            if !errorlevel! equ 0 echo !line!
        ) else if "%FIELD%"=="STATUS" (
            echo !line! | findstr /i "%VALUE%" >nul
            if !errorlevel! equ 0 echo !line!
        ) else if "%FIELD%"=="REGION" (
            echo !line! | findstr /i "%VALUE%" >nul
            if !errorlevel! equ 0 echo !line!
        ) else (
            REM Default: pass through
            echo !line!
        )
    )
)
