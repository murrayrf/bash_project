# CSV Data Processor

## Overview
`csv_processor.sh` is a bash script that processes CSV files by filtering, sorting, and performing calculations (sum, average) on numeric data in specific columns. It simplifies working with CSV data by providing quick, useful operations directly from the command line.

## Why It's Useful
CSV files are a common data format, but processing them manually can be time-consuming, especially when performing actions like filtering rows or calculating values. This script provides a quick and easy way to manipulate CSV files, making it ideal for data analysts, administrators, or anyone working with structured data.

## How to Use
#Copy the code below to test:

Example #1
#Sum the values in column 4 ("Score" in sample_data.csv): This will output the sum of the scores in column 4.

 ./log_analyzer.sh -f sample_data.csv -c 4 -a sum

Example #2
#Filter non-empty rows in column 2 ("Name"): This will display rows where column 2 (the "Name" column) is not empty.

  ./log_analyzer.sh -f sample_data.csv -c 2 -a filter

Example #3
#Calculate the average of ages in column 3: This will calculate and output the average age from column 3.

  ./log_analyzer.sh -f sample_data.csv -c 3 -a avg


***Please run this command first via terminal***
```bash
chmod +x log_analyzer.sh
