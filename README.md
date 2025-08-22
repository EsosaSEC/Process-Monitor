Process Monitor
 A standalone bash script to detect suspicious processes (e.g., `nc`, `curl`, `xmrig`) that may indicate malware or unauthorized activity.

 ## Usage
 1. Run:
    ```bash
    sudo ./process_monitor.sh
    ```
 2. Check alerts in `./alerts/alerts.log`.

 ## Dependencies
 - `ps`, `grep` (standard on Linux).

 ## Example Alert
 ```
 [2025-08-21 22:02:00] ALERT: Suspicious process detected: user 12345 0.0 0.1 1234 5678 pts/0 S 22:00 0:00 nc -l 12345
 ```

 ## Notes
 - Fully standalone with no external configuration dependencies.
 - Line-by-line comments for clarity.
 - Tested in a lab with simulated suspicious processes.
 
 ## Author
 Esosa Okonedo
