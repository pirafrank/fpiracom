#!/usr/bin/env python3

import sys
import re
import datetime
import argparse
from pathlib import Path

def process_line(line, ref_date):
    line = line.strip()
    match = re.search(r'^_posts/(\d{4})-(\d{1,2})-(\d{1,2})-', line)

    if match:
        year = int(match.group(1))
        month = int(match.group(2))
        day = int(match.group(3))

        try:
            post_date = datetime.date(year, month, day)
            if post_date <= ref_date:
                return line
        except ValueError:
            return None

def main():
    # Check if stdin is empty
    if sys.stdin.isatty():
        print("""
No input provided.
Pipe the output of 'git ls-files' or similar git commands to this script.
""")
        sys.exit(1)

    today = datetime.date.today()

    parser = argparse.ArgumentParser(description='Filter Jekyll posts by date')
    parser.add_argument('-d', '--date', type=str, default=None,
        help='date to filter posts up to, included (default: today)')
    args = parser.parse_args()

    if args.date:
        try:
            ref_date = datetime.datetime.strptime(args.date, '%Y-%m-%d').date()
        except ValueError:
            print('Invalid date format')
            sys.exit(1)
    else:
        ref_date = today

    try:
        for line in sys.stdin:
            r = process_line(line, ref_date)
            if r:
                print(r)
    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    main()
