@echo off
REM Workflow: Parallel Data Processing
REM Executes multiple pipelines in parallel and aggregates results
echo ========================================
echo WORKFLOW: Parallel Processing Demo
echo ========================================
echo.

echo [WORKFLOW] Starting parallel data fetching...

REM Execute multiple data sources in parallel (simulated)
echo [PARALLEL-1] Fetching customers...
start /b cmd /c "call C:\work\cli-vs-mcp\cli\datasource\fetch_customers.cmd > temp_parallel_customers.txt"

echo [PARALLEL-2] Fetching transactions...
start /b cmd /c "call C:\work\cli-vs-mcp\cli\datasource\fetch_transactions.cmd > temp_parallel_transactions.txt"

echo [PARALLEL-3] Fetching metrics...
start /b cmd /c "call C:\work\cli-vs-mcp\cli\datasource\fetch_metrics.cmd > temp_parallel_metrics.txt"

REM Wait for parallel operations (simple delay)
timeout /t 2 /nobreak >nul

echo.
echo [WORKFLOW] Processing customer data...
call "C:\work\cli-vs-mcp\cli\aggregators\count_by.cmd" temp_parallel_customers.txt TIER

echo.
echo [WORKFLOW] Processing transaction data...
call "C:\work\cli-vs-mcp\cli\aggregators\count_by.cmd" temp_parallel_transactions.txt STATUS

echo.
echo [WORKFLOW] Showing metrics data...
type temp_parallel_metrics.txt

REM Cleanup
del temp_parallel_*.txt 2>nul

echo.
echo [WORKFLOW] Parallel Processing completed!
