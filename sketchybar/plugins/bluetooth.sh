#!/bin/bash

# Run system_profiler SPBluetoothDataType, skip the first three lines, and capture the output
output=$(system_profiler SPBluetoothDataType | tail -n +4)

# Use awk to extract lines that end with a colon
echo "$output" | awk '/:$/'

