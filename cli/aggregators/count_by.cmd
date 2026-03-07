@echo off
REM Aggregator: Count records by field
REM Usage: count_by.cmd <input_file> <field_name>
setlocal enabledelayedexpansion

set INPUT_FILE=%~1
set FIELD=%~2

if "%INPUT_FILE%"=="" (
    echo [CLI-AGGREGATOR] Error: Missing input file
    exit /b 1
)

if "%FIELD%"=="" set FIELD=STATUS

echo [CLI-AGGREGATOR] Counting records by field: %FIELD%
echo.

REM Initialize counters
set "COUNT_TOTAL=0"
set "COUNT_GOLD=0"
set "COUNT_SILVER=0"
set "COUNT_PLATINUM=0"
set "COUNT_BRONZE=0"
set "COUNT_COMPLETED=0"
set "COUNT_PENDING=0"
set "COUNT_FAILED=0"

set "FIRST_LINE=true"
for /f "usebackq tokens=* delims=" %%a in ("%INPUT_FILE%") do (
    set "line=%%a"
    
    if !FIRST_LINE!==true (
        set "FIRST_LINE=false"
    ) else (
        set /a "COUNT_TOTAL+=1"
        
        REM Count by tier
        echo !line! | findstr /i "GOLD" >nul
        if !errorlevel! equ 0 set /a "COUNT_GOLD+=1"
        
        echo !line! | findstr /i "SILVER" >nul
        if !errorlevel! equ 0 set /a "COUNT_SILVER+=1"
        
        echo !line! | findstr /i "PLATINUM" >nul
        if !errorlevel! equ 0 set /a "COUNT_PLATINUM+=1"
        
        echo !line! | findstr /i "BRONZE" >nul
        if !errorlevel! equ 0 set /a "COUNT_BRONZE+=1"
        
        REM Count by status
        echo !line! | findstr /i "COMPLETED" >nul
        if !errorlevel! equ 0 set /a "COUNT_COMPLETED+=1"
        
        echo !line! | findstr /i "PENDING" >nul
        if !errorlevel! equ 0 set /a "COUNT_PENDING+=1"
        
        echo !line! | findstr /i "FAILED" >nul
        if !errorlevel! equ 0 set /a "COUNT_FAILED+=1"
    )
)

echo.
echo ========================================
echo AGGREGATION RESULTS - %FIELD%
echo ========================================
if "%FIELD%"=="TIER" (
    echo GOLD: !COUNT_GOLD!
    echo SILVER: !COUNT_SILVER!
    echo PLATINUM: !COUNT_PLATINUM!
    echo BRONZE: !COUNT_BRONZE!
) else if "%FIELD%"=="STATUS" (
    echo COMPLETED: !COUNT_COMPLETED!
    echo PENDING: !COUNT_PENDING!
    echo FAILED: !COUNT_FAILED!
) else (
    echo TOTAL RECORDS: !COUNT_TOTAL!
)
echo ========================================
