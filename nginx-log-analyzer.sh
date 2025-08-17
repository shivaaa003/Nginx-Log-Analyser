#!/usr/bin/env bash

# Check if log file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <nginx-access-log-file>"
    exit 1
fi

LOG_FILE=$1

# Check if file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File $LOG_FILE not found!"
    exit 1
fi

# 1. Top 5 IP addresses
echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""

# 2. Top 5 requested paths
echo "Top 5 requested paths:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""

# 3. Top 5 response status codes
echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""

# 4. Top 5 user agents
echo "Top 5 user agents:"
awk -F\" '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | sed 's/^ *//'
echo ""
