# Process Monitor

A bash script to detect suspicious processes (e.g., `nc`, `miner`, `curl`, `xmrig`, `python.*http`) that may indicate malware or backdoors. Alerts are logged to a specified file.

## Usage
1. Ensure `config.sh` with `ALERTS_LOG`.
2. Run:
   ```bash
   sudo ./process_monitor.sh
   ```
3. Check alerts in the log file.

## Dependencies
- ps, grep.

## Example Alert
```bash
[2025-07-11 11:17:00] ALERT: Suspicious process detected: user 1234 nc -l 445
```
