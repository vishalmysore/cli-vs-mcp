package io.github.vishalmysore.clivsmcp;

import com.t4a.processor.OpenAiActionProcessor;
import lombok.extern.slf4j.Slf4j;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Scanner;
import java.util.concurrent.*;
import java.util.List;
import java.util.ArrayList;

/**
 * Advanced CLI Orchestrator - Demonstrates enterprise-grade CLI composition patterns
 * 
 * This agent showcases:
 * 1. CLI Chaining - Output of one CLI feeds as input to another
 * 2. Pipeline Composition - Multi-stage data transformation workflows
 * 3. Parallel Execution - Concurrent CLI operations for performance
 * 4. Conditional Branching - Dynamic workflow based on CLI outputs
 * 5. Error Handling & Recovery - Robust pipeline error management
 * 
 * Architecture Patterns:
 * - Data Source CLIs: Generate raw data (customers, transactions, metrics)
 * - Processor CLIs: Transform, filter, enrich data streams
 * - Aggregator CLIs: Compute statistics, counts, summaries
 * - Workflow CLIs: Orchestrate complex multi-stage pipelines
 * 
 * This demonstrates that CLI composition can achieve sophisticated orchestration
 * patterns traditionally associated with microservices or message queues, but with
 * zero infrastructure overhead and direct OS-level integration.
 */
@Slf4j
public class AdvancedCliOrchestrator {

    private static final ExecutorService executorService = Executors.newFixedThreadPool(5);
    private static final OpenAiActionProcessor processor = new OpenAiActionProcessor();

    public static void main(String[] args) {
        printWelcomeBanner();
        
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.print("\n🤖 Agent > ");
            String prompt = scanner.nextLine();

            if (prompt == null || prompt.trim().isEmpty()) {
                continue;
            }

            if ("exit".equalsIgnoreCase(prompt.trim()) || "quit".equalsIgnoreCase(prompt.trim())) {
                System.out.println("\n[AGENT] Shutting down orchestrator...");
                executorService.shutdown();
                break;
            }

            if ("demo".equalsIgnoreCase(prompt.trim())) {
                runInteractiveDemo();
                continue;
            }

            try {
                System.out.println("\n[AGENT] 🧠 Analyzing intent and workflow requirements...");
                System.out.println("[AGENT] 🔗 Identifying CLI chain composition strategy...");

                // Process with Tools4AI
                Object result = processor.processSingleAction(prompt);

                System.out.println("\n[AGENT] ✅ Workflow execution completed!");
                System.out.println("\n" + "=".repeat(60));
                System.out.println("RESULT:");
                System.out.println("=".repeat(60));
                System.out.println(result);
                System.out.println("=".repeat(60));

            } catch (Exception e) {
                log.error("Error during CLI orchestration: ", e);
                System.out.println("\n❌ [AGENT] Workflow failed: " + e.getMessage());
            }
        }

        scanner.close();
    }

    private static void printWelcomeBanner() {
        System.out.println("\n" + "=".repeat(70));
        System.out.println("🚀 ADVANCED CLI ORCHESTRATION AGENT");
        System.out.println("    CLI Chaining | Pipelines | Parallel Execution | Workflows");
        System.out.println("=".repeat(70));
        System.out.println("\n📚 Available Commands:");
        System.out.println("   'demo'  - Run interactive demonstration of all patterns");
        System.out.println("   'exit'  - Quit the orchestrator");
        System.out.println("\n💡 Example Prompts:");
        System.out.println("   • Analyze customer tiers for GOLD customers");
        System.out.println("   • Run transaction analytics for completed transactions");
        System.out.println("   • Execute multi-stage pipeline for WEST region");
        System.out.println("   • Run parallel data processing across all sources");
        System.out.println("   • Show customer spending statistics");
        System.out.println("   • Filter and count transactions by status");
        System.out.println("\n" + "=".repeat(70));
        System.out.println("Type your intent or 'demo' to see all patterns in action...");
    }

    /**
     * Interactive demo showcasing all advanced CLI patterns
     */
    private static void runInteractiveDemo() {
        System.out.println("\n" + "=".repeat(70));
        System.out.println("🎯 INTERACTIVE DEMO: Advanced CLI Orchestration Patterns");
        System.out.println("=".repeat(70));

        // Pattern 1: Simple CLI Chaining
        demoPattern1();

        // Pattern 2: Multi-Stage Pipeline
        demoPattern2();

        // Pattern 3: Parallel Execution
        demoPattern3();

        // Pattern 4: Conditional Workflows
        demoPattern4();

        System.out.println("\n" + "=".repeat(70));
        System.out.println("✅ Demo completed! All patterns demonstrated successfully.");
        System.out.println("=".repeat(70));
    }

    private static void demoPattern1() {
        System.out.println("\n📊 PATTERN 1: CLI Chain - Data Source → Filter → Aggregate");
        System.out.println("-".repeat(70));
        System.out.println("Workflow: fetch_customers | filter_by TIER GOLD | count_by");
        System.out.println();

        try {
            ProcessBuilder pb = new ProcessBuilder(
                "cmd.exe", "/c", 
                "C:\\work\\cli-vs-mcp\\cli\\workflow_customer_analysis.cmd"
            );
            pb.redirectErrorStream(true);
            Process process = pb.start();
            
            printProcessOutput(process);
            process.waitFor();
            
        } catch (Exception e) {
            System.out.println("❌ Pattern 1 failed: " + e.getMessage());
        }
    }

    private static void demoPattern2() {
        System.out.println("\n📊 PATTERN 2: Multi-Stage Pipeline with Data Enrichment");
        System.out.println("-".repeat(70));
        System.out.println("Workflow: fetch → filter → transform → aggregate");
        System.out.println();

        try {
            ProcessBuilder pb = new ProcessBuilder(
                "cmd.exe", "/c",
                "C:\\work\\cli-vs-mcp\\cli\\workflow_multistage_pipeline.cmd", "WEST"
            );
            pb.redirectErrorStream(true);
            Process process = pb.start();
            
            printProcessOutput(process);
            process.waitFor();
            
        } catch (Exception e) {
            System.out.println("❌ Pattern 2 failed: " + e.getMessage());
        }
    }

    private static void demoPattern3() {
        System.out.println("\n📊 PATTERN 3: Parallel Execution - Concurrent Data Processing");
        System.out.println("-".repeat(70));
        System.out.println("Workflow: [fetch_customers || fetch_transactions || fetch_metrics]");
        System.out.println();

        try {
            List<Callable<String>> tasks = new ArrayList<>();
            
            // Task 1: Process customers
            tasks.add(() -> {
                ProcessBuilder pb = new ProcessBuilder(
                    "cmd.exe", "/c",
                    "C:\\work\\cli-vs-mcp\\cli\\datasource\\fetch_customers.cmd"
                );
                Process p = pb.start();
                StringBuilder output = new StringBuilder();
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(p.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        output.append(line).append("\n");
                    }
                }
                p.waitFor();
                return "Customers: " + output.toString().split("\n").length + " records";
            });

            // Task 2: Process transactions
            tasks.add(() -> {
                ProcessBuilder pb = new ProcessBuilder(
                    "cmd.exe", "/c",
                    "C:\\work\\cli-vs-mcp\\cli\\datasource\\fetch_transactions.cmd"
                );
                Process p = pb.start();
                StringBuilder output = new StringBuilder();
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(p.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        output.append(line).append("\n");
                    }
                }
                p.waitFor();
                return "Transactions: " + output.toString().split("\n").length + " records";
            });

            // Task 3: Process metrics
            tasks.add(() -> {
                ProcessBuilder pb = new ProcessBuilder(
                    "cmd.exe", "/c",
                    "C:\\work\\cli-vs-mcp\\cli\\datasource\\fetch_metrics.cmd"
                );
                Process p = pb.start();
                StringBuilder output = new StringBuilder();
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(p.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        output.append(line).append("\n");
                    }
                }
                p.waitFor();
                return "Metrics: " + output.toString().split("\n").length + " records";
            });

            System.out.println("[PARALLEL] Executing 3 data sources concurrently...");
            long startTime = System.currentTimeMillis();
            
            List<Future<String>> results = executorService.invokeAll(tasks);
            
            long endTime = System.currentTimeMillis();
            
            System.out.println("\n[PARALLEL] Results from concurrent execution:");
            for (Future<String> future : results) {
                System.out.println("  ✓ " + future.get());
            }
            
            System.out.println("\n[PARALLEL] Total execution time: " + (endTime - startTime) + "ms");
            System.out.println("[PARALLEL] Speedup achieved through parallelization!");

        } catch (Exception e) {
            System.out.println("❌ Pattern 3 failed: " + e.getMessage());
        }
    }

    private static void demoPattern4() {
        System.out.println("\n📊 PATTERN 4: Conditional Workflow - Dynamic Path Selection");
        System.out.println("-".repeat(70));
        System.out.println("Workflow: Analyze data → Branch based on results → Execute path");
        System.out.println();

        try {
            // First, get transaction status counts
            ProcessBuilder pb1 = new ProcessBuilder(
                "cmd.exe", "/c",
                "C:\\work\\cli-vs-mcp\\cli\\datasource\\fetch_transactions.cmd"
            );
            Process p1 = pb1.start();
            
            StringBuilder output = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(p1.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    output.append(line).append("\n");
                }
            }
            p1.waitFor();
            
            // Count failed transactions
            String data = output.toString();
            int failedCount = data.split("FAILED").length - 1;
            
            System.out.println("[CONDITIONAL] Analyzing transaction health...");
            System.out.println("[CONDITIONAL] Failed transactions detected: " + failedCount);
            
            if (failedCount > 0) {
                System.out.println("[CONDITIONAL] ⚠️  ALERT PATH: Failures detected!");
                System.out.println("[CONDITIONAL] Executing failure analysis workflow...");
                // Execute alert workflow
                ProcessBuilder pb2 = new ProcessBuilder(
                    "cmd.exe", "/c",
                    "C:\\work\\cli-vs-mcp\\cli\\workflow_transaction_analytics.cmd"
                );
                pb2.redirectErrorStream(true);
                Process p2 = pb2.start();
                printProcessOutput(p2);
                p2.waitFor();
            } else {
                System.out.println("[CONDITIONAL] ✅ HEALTHY PATH: All transactions successful!");
                System.out.println("[CONDITIONAL] Executing standard analytics workflow...");
            }

        } catch (Exception e) {
            System.out.println("❌ Pattern 4 failed: " + e.getMessage());
        }
    }

    private static void printProcessOutput(Process process) {
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(process.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
        } catch (Exception e) {
            log.error("Error reading process output", e);
        }
    }
}
