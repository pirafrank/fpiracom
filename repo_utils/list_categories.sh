#!/bin/bash
grep -Rni 'category:' _posts | awk -F'[][]' '{print $2}' | sed -e s@\'@@g -e s@\"@@g | sort | uniq -c

