#!/bin/bash
#!/bin/bash

# Check if no arguments are provided or if the first argument is not a number
if [[ $# -lt 1 || ! $1 =~ ^[0-9]+$ ]]; then
  echo "Usage: ./mean.sh <column> [file.csv]" >&2
  exit 1
fi

# Get the column number from the first argument
column=$1

# Read from file if provided, otherwise read from stdin
if [[ -n $2 ]]; then
  file=$2
  if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found." >&2
    exit 1
  fi
  data=$(tail -n +2 "$file")  # Skip header
else
  data=$(tail -n +2)  # Skip header from stdin
fi

# Extract the specified column, ignoring any missing values
sum=0
count=0
while IFS=, read -r -a fields; do
  value="${fields[$((column - 1))]}"  # Adjust index since columns are 1-based
  if [[ -n $value && $value =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    sum=$(echo "$sum + $value" | bc)
    count=$((count + 1))
  fi
done <<< "$data"

# Calculate the mean and print it
if [[ $count -eq 0 ]]; then
  echo "Error: No valid data in the specified column." >&2
  exit 1
fi

mean=$(echo "scale=2; $sum / $count" | bc)
echo "Mean of column $column: $mean"
