#!/bin/sh

file="$1"

# Check if file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found."
    return 1
fi

# Check if file is empty
if [ ! -s "$file" ]; then
    echo "Error: File '$file' is empty."
    return 1
fi

# Check for required iCal elements
begin_vcalendar=$(grep -c '^BEGIN:VCALENDAR' "$file")
end_vcalendar=$(grep -c '^END:VCALENDAR' "$file")
begin_vevent=$(grep -c '^BEGIN:VEVENT' "$file")
end_vevent=$(grep -c '^END:VEVENT' "$file")

if [ "$begin_vcalendar" -ne 1 ] || [ "$end_vcalendar" -ne 1 ]; then
    echo "Error: Invalid or missing VCALENDAR tags in '$file'."
    return 1
fi

if [ "$begin_vevent" -ne "$end_vevent" ]; then
    echo "Error: Mismatched VEVENT tags in '$file'."
    return 1
fi

# Check for required fields within VEVENT
events=$(sed -n '/^BEGIN:VEVENT/,/^END:VEVENT/p' "$file")
echo "$events" | while IFS= read -r line; do
    case "$line" in
        BEGIN:VEVENT) 
            dtstart=0
            dtend=0
            summary=0
            ;;
        DTSTART:*) dtstart=1 ;;
        DTEND:*) dtend=1 ;;
        SUMMARY:*) summary=1 ;;
        END:VEVENT)
            if [ "$dtstart" -eq 0 ] || [ "$dtend" -eq 0 ] || [ "$summary" -eq 0 ]; then
                echo "Error: Missing required fields in VEVENT in '$file'."
                return 1
            fi
            ;;
    esac
done

echo "iCal file '$file' appears to be consistent."
return 0

