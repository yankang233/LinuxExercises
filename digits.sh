#!/bin/bash
sum=0

# Loop through the range of numbers from 1000 to 2000
for num in {1000..2000}; do
  # Check if the number only contains digits 0 and 1 using a regular expression
  if [[ $num =~ ^[01]+$ ]]; then
    # If the number matches, add it to the sum
    sum=$((sum + num))
  fi
done

# Output the result
echo "The sum of numbers between 1000 and 2000 containing only 0 and 1 is: $sum"
