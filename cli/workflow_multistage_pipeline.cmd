@echo off
REM Workflow: Multi-stage Data Enrichment Pipeline
REM Chains: fetch_customers -> filter -> transform -> count
setlocal enabledelayedexpansion

set REGION=%~1
if "%REGION%"=="" set REGION=WEST

echo ========================================
echo WORKFLOW: Multi-Stage Data Pipeline
echo Target Region: %REGION%
echo ========================================
echo.

echo [WORKFLOW] Stage 1: Data Extraction
call "C:\work\cli-vs-mcp\cli\datasource\fetch_customers.cmd" > temp_stage1.txt

echo [WORKFLOW] Stage 2: Regional Filtering (Region=%REGION%)
call "C:\work\cli-vs-mcp\cli\processors\filter_by.cmd" temp_stage1.txt REGION EQUALS %REGION% > temp_stage2.txt

echo [WORKFLOW] Stage 3: Data Enrichment
call "C:\work\cli-vs-mcp\cli\processors\transform_data.cmd" temp_stage2.txt ENRICH > temp_stage3.txt

echo [WORKFLOW] Stage 4: Aggregation
call "C:\work\cli-vs-mcp\cli\aggregators\count_by.cmd" temp_stage3.txt TIER

echo.
echo [WORKFLOW] Showing enriched results:
echo.
type temp_stage3.txt

REM Cleanup
del temp_stage1.txt temp_stage2.txt temp_stage3.txt 2>nul

echo.
echo [WORKFLOW] Multi-Stage Pipeline completed!
