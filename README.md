# CPU-Health-Check-Script
This is a shell script that helps tell the health of the CPU and other things

# Health Check Script

This repository contains a shell script named `health_check.sh` that analyzes the health of a virtual machine based on CPU, memory, and disk space usage. If any of these parameters exceed 60 percent, the script declares the health as not healthy. The script also supports a command-line argument named "explain" which, when passed, explains the reason for the health status along with printing the health status.

## How to Run the Script

1. Make the script executable:
   ```bash
   chmod +x health_check.sh
   ```

2. Run the script:
   ```bash
   ./health_check.sh
   ```

3. Run the script with the "explain" argument:
   ```bash
   ./health_check.sh explain
   ```

