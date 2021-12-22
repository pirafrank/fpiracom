SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "${SCRIPT_DIR}/../"
grep -Rni 'tags:' _posts/* | \
  awk -F'[][]' '{print $2}' | \
  tr -d \' | tr -d \" | \
  sed 's/,\s/,/g' | sed 's/,/\n/g' | \
  sort | uniq -c
