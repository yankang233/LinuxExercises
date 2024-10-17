#!/bin/bash

cat Property_Tax_Roll.csv | \
grep "MADISON SCHOOLS" | \
cut -d',' -f7 | \
awk '{sum += $1; count++} END {if (count > 0) print "Average TotalAssessedValue:", sum / count}'
