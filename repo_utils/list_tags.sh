grep -Rni 'tags:' _posts/* | \
  awk -F'[][]' '{print $2}' | \
  tr -d \' | tr -d \" | \
  sed 's/,\s/,/g' | sed 's/,/\n/g' | \
  sort | uniq -c
