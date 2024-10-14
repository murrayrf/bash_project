#!/bin/bash

# Display usage information
usage() {
    echo "Usage: $0 [-c column] [-s sort_order] [-a action] [-h]"
    echo "Options:"
    echo "  -c column       Specify the column (by number) to filter or calculate."
    echo "  -s sort_order   Sort the CSV file by the specified column (asc/desc)."
    echo "  -a action       Specify the action: filter, sum, avg."
    echo "  -h              Display this help message."
    exit 1
}

# CSV file is predefined as sample_data.csv
csv_file="sample_data.csv"

# Validate input
if [[ $# -eq 0 ]]; then
    usage
fi

# Initialize variables
column=""
sort_order=""
action=""

# Parse command-line options
while getopts "c:s:a:h" opt; do
    case $opt in
        c) column="$OPTARG" ;;
        s) sort_order="$OPTARG" ;;
        a) action="$OPTARG" ;;
        h) usage ;;
        *) echo "Invalid option: -$OPTARG" >&2; usage ;;
    esac
done

# Check if the column is a valid number
if ! [[ "$column" =~ ^[0-9]+$ ]]; then
    echo "Error: Column must be a valid number." >&2
    exit 1
fi

# Perform actions based on user input
case "$action" in
    filter)
        awk -F, -v col="$column" 'NR == 1 || $col != ""' "$csv_file"
        ;;
    sum)
        awk -F, -v col="$column" 'NR > 1 {sum += $col} END {print "Sum:", sum}' "$csv_file"
        ;;
    avg)
        awk -F, -v col="$column" 'NR > 1 {sum += $col; count++} END {print "Average:", sum/count}' "$csv_file"
        ;;
    *)
        echo "Error: Invalid action. Choose from filter, sum, or avg." >&2
        exit 1
        ;;
esac

# Sort the CSV file if requested
if [[ -n "$sort_order" ]]; then
    if [[ "$sort_order" == "asc" ]]; then
        sort -t, -k"$column" -n "$csv_file"
    elif [[ "$sort_order" == "desc" ]]; then
        sort -t, -k"$column" -nr "$csv_file"
    else
        echo "Error: Invalid sort order. Use 'asc' or 'desc'." >&2
        exit 1
    fi
fi
