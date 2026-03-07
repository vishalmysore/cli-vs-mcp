@echo off
REM Workflow: Transaction Analytics Pipeline
REM Chains: fetch_transactions -> filter_by STATUS -> calculate_stats
echo ========================================
echo WORKFLOW: Transaction Analytics
echo ========================================
echo.
echo [WORKFLOW] Step 1: Fetching transactions...
call "C:\work\cli-vs-mcp\cli\datasource\fetch_transactions.cmd" > temp_transactions.txt

echo [WORKFLOW] Step 2: Filtering COMPLETED transactions...
call "C:\work\cli-vs-mcp\cli\processors\filter_by.cmd" temp_transactions.txt STATUS EQUALS COMPLETED > temp_completed.txt

echo [WORKFLOW] Step 3: Displaying filtered results...
type temp_completed.txt
echo.

echo [WORKFLOW] Step 4: Calculating statistics...
call "C:\work\cli-vs-mcp\cli\aggregators\calculate_stats.cmd" temp_completed.txt AMOUNT

REM Cleanup
del temp_transactions.txt temp_completed.txt 2>nul

echo.
echo [WORKFLOW] Transaction Analytics completed!
