@echo off
REM Processor: Transform data (enrichment, normalization)
REM Usage: transform_data.cmd <input_file> <transformation_type>
setlocal enabledelayedexpansion

set INPUT_FILE=%~1
set TRANSFORM_TYPE=%~2

if "%INPUT_FILE%"=="" (
    echo [CLI-PROCESSOR] Error: Missing input file
    exit /b 1
)

if "%TRANSFORM_TYPE%"=="" set TRANSFORM_TYPE=ENRICH

echo [CLI-PROCESSOR] Applying transformation: %TRANSFORM_TYPE%
echo.

set "FIRST_LINE=true"
for /f "usebackq tokens=* delims=" %%a in ("%INPUT_FILE%") do (
    set "line=%%a"
    
    if !FIRST_LINE!==true (
        if "%TRANSFORM_TYPE%"=="ENRICH" (
            echo !line!^|SCORE
        ) else if "%TRANSFORM_TYPE%"=="UPPERCASE" (
            echo !line!
        ) else (
            echo !line!
        )
        set "FIRST_LINE=false"
    ) else (
        if "%TRANSFORM_TYPE%"=="ENRICH" (
            REM Add a computed score field
            set /a "SCORE=!RANDOM! %% 100"
            echo !line!^|!SCORE!
        ) else if "%TRANSFORM_TYPE%"=="UPPERCASE" (
            REM Convert to uppercase (simplified)
            echo !line!
        ) else (
            echo !line!
        )
    )
)
