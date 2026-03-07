@echo off
REM Workflow: Customer Analysis Pipeline
REM Chains: fetch_customers -> filter_by TIER -> count_by
echo ========================================
echo WORKFLOW: Customer Tier Analysis
echo ========================================
echo.
echo [WORKFLOW] Step 1: Fetching customers...
call "C:\work\cli-vs-mcp\cli\datasource\fetch_customers.cmd" > temp_customers.txt

echo [WORKFLOW] Step 2: Filtering GOLD tier customers...
call "C:\work\cli-vs-mcp\cli\processors\filter_by.cmd" temp_customers.txt TIER EQUALS GOLD > temp_filtered.txt

echo [WORKFLOW] Step 3: Displaying filtered results...
type temp_filtered.txt
echo.

echo [WORKFLOW] Step 4: Counting results...
call "C:\work\cli-vs-mcp\cli\aggregators\count_by.cmd" temp_filtered.txt TIER

REM Cleanup
del temp_customers.txt temp_filtered.txt 2>nul

echo.
echo [WORKFLOW] Customer Tier Analysis completed!
