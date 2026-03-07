@echo off
REM Aggregator: Calculate statistics (sum, avg, min, max)
REM Usage: calculate_stats.cmd <input_file> <field_name>
setlocal enabledelayedexpansion

set INPUT_FILE=%~1
set FIELD=%~2

if "%INPUT_FILE%"=="" (
    echo [CLI-AGGREGATOR] Error: Missing input file
    exit /b 1
)

if "%FIELD%"=="" set FIELD=AMOUNT

echo [CLI-AGGREGATOR] Calculating statistics for field: %FIELD%
echo.

REM Initialize variables
set "SUM=0"
set "COUNT=0"
set "MIN=999999"
set "MAX=0"

set "FIRST_LINE=true"
for /f "usebackq tokens=1,2,3,4,5 delims=|" %%a in ("%INPUT_FILE%") do (
    if !FIRST_LINE!==true (
        set "FIRST_LINE=false"
    ) else (
        set /a "COUNT+=1"
        
        REM Extract numeric value (simplified - assumes field 3 or 4)
        if "%FIELD%"=="AMOUNT" set "VALUE=%%c"
        if "%FIELD%"=="SPENDING" set "VALUE=%%d"
        
        REM Clean the value
        set "VALUE=!VALUE: =!"
        
        REM Calculate sum
        set /a "SUM+=!VALUE!"
        
        REM Calculate min
        if !VALUE! LSS !MIN! set "MIN=!VALUE!"
        
        REM Calculate max
        if !VALUE! GTR !MAX! set "MAX=!VALUE!"
    )
)

REM Calculate average
if !COUNT! GTR 0 (
    set /a "AVG=!SUM! / !COUNT!"
) else (
    set "AVG=0"
)

echo.
echo ========================================
echo STATISTICAL ANALYSIS - %FIELD%
echo ========================================
echo COUNT: !COUNT!
echo SUM: $!SUM!
echo AVERAGE: $!AVG!
echo MINIMUM: $!MIN!
echo MAXIMUM: $!MAX!
echo ========================================
