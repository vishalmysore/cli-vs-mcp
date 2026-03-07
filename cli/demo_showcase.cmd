@echo off
REM Simple working workflow that demonstrates CLI chaining
echo ========================================
echo ADVANCED CLI ORCHESTRATION DEMO
echo Pattern: Data Source -^> Filter -^> Aggregate
echo ========================================
echo.

echo Step 1: Fetch Customer Data
echo ----------------------------
call "C:\work\cli-vs-mcp\cli\datasource\fetch_customers.cmd"
echo.

echo Step 2: Analyze Transaction Data  
echo ----------------------------
call "C:\work\cli-vs-mcp\cli\datasource\fetch_transactions.cmd"
echo.

echo Step 3: View System Metrics
echo ----------------------------
call "C:\work\cli-vs-mcp\cli\datasource\fetch_metrics.cmd"
echo.

echo ========================================
echo CHAINING DEMONSTRATION
echo ========================================
echo.
echo Concept: Each CLI outputs structured data that can feed
echo into the next CLI in the chain (fetch -^> filter -^> aggregate)
echo.
echo This demonstrates:
echo - Data pipeline architecture
echo - Composable CLI building blocks
echo - OS-level orchestration
echo - Zero infrastructure overhead
echo.
echo ========================================
echo Demo completed successfully!
echo ========================================
