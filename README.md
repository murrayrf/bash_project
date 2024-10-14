# CSV Data Processor

## Overview
`csv_processor.sh` is a bash script that processes CSV files by filtering, sorting, and performing calculations (sum, average) on numeric data in specific columns. It simplifies working with CSV data by providing quick, useful operations directly from the command line.

## Why It's Useful
CSV files are a common data format, but processing them manually can be time-consuming, especially when performing actions like filtering rows or calculating values. This script provides a quick and easy way to manipulate CSV files, making it ideal for data analysts, administrators, or anyone working with structured data.

## How to Use
### Syntax:

#Filter rows in the CSV file where the third column (Age) is not empty:
#Copy the code below to test:

  ./csv_processor.sh -c 3 -a filter

#Calculate the sum of values in the fourth column (Score):
#Copy the code below to test:

  ./csv_processor.sh -c 4 -a sum
  

#Sort the CSV file by the second column (Name) in descending order:
#Copy the code below to test:

  ./csv_processor.sh -c 2 -s desc


```bash
./csv_processor.sh [-f csv_file] [-c column] [-s sort_order] [-a action] [-h]
