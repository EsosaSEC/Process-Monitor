#!/bin/bash
# Monitor suspicious processes

# Configuration
ALERTS_DIR="./alerts"  # Directory where alert logs will be stored
ALERTS_LOG="$ALERTS_DIR/alerts.log"  # Full path to the alert log file

# Define suspicious process patterns with better specificity
# Patterns target specific malicious command structures and behaviors
SUSPICIOUS_PROCESSES="(nc\s+-[le]|minerd|cpuminer|xmrig|perl\s+-e\s*'|curl\s+-s\s*[0-9]|sshd:\s+.*@|crond\s+.*[0-9]|botnet|python.*-c.*http|python.*import.*socket)"

# Create alerts directory
mkdir -p "$ALERTS_DIR"  # Creates the alerts directory if it doesn't exist
chmod 755 "$ALERTS_DIR"  # Sets permissions: owner=rwx, group=rx, others=rx

# Check running processes with enhanced filtering
# ps aux: List all running processes with detailed information
# grep -E: Use extended regex to match suspicious patterns
# grep -v grep: Exclude the grep command itself from results
# grep -v "sshd: [a-zA-Z]": Exclude normal user SSH sessions (legitimate connections)
# grep -v "crond: user": Exclude normal cron job processes (legitimate system jobs)
suspicious_procs=$(ps aux | grep -E "$SUSPICIOUS_PROCESSES" | grep -v grep | grep -v "sshd: [a-zA-Z]" | grep -v "crond: user")

# Generate alerts only if suspicious processes are found
if [ -n "$suspicious_procs" ]; then  # Check if variable is not empty
    # Loop through each suspicious process found
    while IFS= read -r line; do  # IFS= preserves whitespace, read -r prevents backslash interpretation
        # Append alert to log file with timestamp and process details
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: Suspicious process detected: $line" >> "$ALERTS_LOG"
    done <<< "$suspicious_procs"  # Feed the variable content into the while loop
fi  # End of if condition
