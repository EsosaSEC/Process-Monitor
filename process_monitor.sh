#!/bin/bash
# Monitor suspicious processes

# Configuration

ALERTS_DIR="./alerts"  # Directory where alert logs will be stored.
ALERTS_LOG="$ALERTS_DIR/alerts.log"  # Full path to the alert log file.

# Define suspicious process names

SUSPICIOUS_PROCESSES="nc|minerd|cpuminer|xmrig|perl|curl|sshd|crond|botnet|python.*http|"  # List of process names or patterns associated with potential malicious activity.

# Create alerts directory

mkdir -p "$ALERTS_DIR"  # Creates the alerts directory if it doesn't exist, ensuring logs can be written.
chmod 755 "$ALERTS_DIR"  # Sets permissions to allow read/write/execute for owner and read/execute for others.

# Check running processes
suspicious_procs=$(ps aux | grep -E "$SUSPICIOUS_PROCESSES" | grep -v grep)  # Lists all running processes, filters for suspicious ones, and excludes grep itself from the results.

# Generate alerts

if [ -n "$suspicious_procs" ]; then  # Checks if any suspicious processes were found.
    while IFS= read -r line; do  # Loops through each line of filtered suspicious process data.
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: Suspicious process detected: $line" >> "$ALERTS_LOG"  # Logs an alert with the suspicious process details to ALERTS_LOG.
    done <<< "$suspicious_procs"  # Feeds the suspicious_procs variable into the while loop.
fi  # Ends the if condition for alert generation.
