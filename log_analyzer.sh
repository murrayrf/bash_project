#!/bin/bash

# Display usage information
usage() {
    echo "Usage: $0 [-f csv_file] [-c column] [-s sort_order] [-a action] [-h]"
    echo "Options:"
    echo "  -f csv_file     Specify the CSV file to process (e.g., sample_data.csv)."
    echo "  -c column       Specify the column (by number) to filter or calculate."
    echo "  -s sort_order   Sort the CSV file by the specified column (asc/desc)."
    echo "  -a action       Specify the action: filter, sum, avg."
    echo "  -h              Display this help message."
    exit 1
}

# Validate input
if [[ $# -eq 0 ]]; then
    usage
fi

# Initialize variables
csv_file=""
column=""
sort_order=""
action=""

# Parse command-line options
while getopts "f:c:s:a:h" opt; do
    case $opt in
        f) csv_file="$OPTARG" ;;
        c) column="$OPTARG" ;;
        s) sort_order="$OPTARG" ;;
        a) action="$OPTARG" ;;
        h) usage ;;
        *) echo "Invalid option: -$OPTARG" >&2; usage ;;
    esac
done

# Check if CSV file is provided and exists
if [[ -z "$csv_file" ]]; then
    echo "Error: CSV file is required." >&2
    usage
elif [[ ! -f "$csv_file" ]]; then
    echo "Error: CSV file '$csv_file' does not exist." >&2
    exit 1
fi

# Check if the column is a valid number
if ! [[ "$column" =~ ^[0-9]+$ ]]; then
    echo "Error: Column must be a valid number." >&2
    exit 1
fi

# Perform actions based on user input
case "$action" in
    filter)
        # Show rows where the column is not empty
        awk -F, -v col="$column" 'NR == 1 || $col != ""' "$csv_file"
        ;;
    sum)
        # Sum the values in the specified column
        awk -F, -v col="$column" 'NR > 1 {sum += $col} END {print "Sum:", sum}' "$csv_file"
        ;;
    avg)
        # Calculate the average of the values in the specified column
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
