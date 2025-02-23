#!/bin/bash

# Example: Analyze syslog for errors
LOG_FILE="/var/log/syslog"

grep -i "error\|fail\|critical" "$LOG_FILE"
