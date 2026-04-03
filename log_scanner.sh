#!/bin/bash

# Define the log file to scan (auth.log is standard for logins)
LOG_FILE="/var/log/auth.log"
OUTPUT_FILE="failed_logins.txt"

echo "--- Starting Security Scan ---"

# Check if the log file exists
if [ -f "$LOG_FILE" ]; then
    echo "Scanning $LOG_FILE for failed attempts..."

    # Use grep to find "Failed password", then awk to pull out the IP address
    grep "Failed password" "$LOG_FILE" | awk '{print $(NF-3)}' | sort | uniq -c > "$OUTPUT_FILE"

    echo "Scan complete. Results saved to $OUTPUT_FILE"
    echo "Number of failed attempts found:"
    wc -l < "$OUTPUT_FILE"
else
    echo "Error: $LOG_FILE not found. Are you on a Linux system?"
fi
