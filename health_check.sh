#!/bin/bash

# Function to check CPU usage
check_cpu_usage() {
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
  echo $cpu_usage
}

# Function to check memory usage
check_memory_usage() {
  memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
  echo $memory_usage
}

# Function to check disk space usage
check_disk_space_usage() {
  disk_space_usage=$(df -h / | grep / | awk '{print $5}' | sed 's/%//g')
  echo $disk_space_usage
}

# Function to analyze the health of the virtual machine
analyze_health() {
  cpu=$(check_cpu_usage)
  memory=$(check_memory_usage)
  disk=$(check_disk_space_usage)

  if (( $(echo "$cpu > 60" | bc -l) )) || (( $(echo "$memory > 60" | bc -l) )) || (( $(echo "$disk > 60" | bc -l) )); then
    echo "Health: Not Healthy"
    if [ "$1" == "explain" ]; then
      echo "Reason(s):"
      if (( $(echo "$cpu > 60" | bc -l) )); then
        echo "CPU usage is above 60% ($cpu%)"
      fi
      if (( $(echo "$memory > 60" | bc -l) )); then
        echo "Memory usage is above 60% ($memory%)"
      fi
      if (( $(echo "$disk > 60" | bc -l) )); then
        echo "Disk space usage is above 60% ($disk%)"
      fi
    fi
  else
    echo "Health: Healthy"
  fi
}

# Main script execution
if [ "$1" == "explain" ]; then
  analyze_health "explain"
else
  analyze_health
fi
