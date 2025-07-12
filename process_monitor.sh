#!/bin/bash

# Monitor suspicious processes
source ./config.sh

# Define suspicious process names
SUSPICIOUS_PROCESSES="nc|minerd|cpuminer|xmrig|perl|curl|sshd|crond|botnet|python.*http|"

# Check running processes
suspicious_procs=$(ps aux | grep -E "$SUSPICIOUS_PROCESSES" | grep -v grep)

# Generate alerts
if [ -n "$suspicious_procs" ]; then
    while IFS= read -r line; do
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: Suspicious process detected: $line" >> "$ALERTS_LOG"
    done <<< "$suspicious_procs"
fi
