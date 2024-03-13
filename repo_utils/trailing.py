#!/usr/bin/env python

import sys
import os
import fileinput
import pathlib


"""
How to use:

fd -e md -e html -e disabled --exclude 'vendor/**' --exclude '_posts/**' | \
xargs -I {} grep 'permalink' "{}" /dev/null | \
python repo_utils/trailing.py
"""

def replace_line_in_file(filepath, pattern, replacement):
    print(f'Match found: filepath: [{filepath}]')
    print(f'  replacing [{pattern}] with [{replacement}]')
    with fileinput.input(filepath, inplace=1) as file:
        for _line in file:
            if pattern in _line:
                _line = _line.replace(pattern, replacement)
            sys.stdout.write(_line)

def process_input_lines(input_lines, script_dir, have_to_remove):
    for line in input_lines:
        print(f'Working on: {line}')
        tokens = line.split(':')
        file_path = tokens[0]
        match = (":".join(tokens[1:])).replace("\n","")
        if have_to_remove:
            if (len(match) > 0) and (match[-1] == '/'):
                updated_line = match[:-1]
                file_path = os.path.join(script_dir, "../", file_path)
                replace_line_in_file(file_path, match, updated_line)
        else:
            if (len(match) > 0) and (match[-1] != '/'):
                updated_line = match + '/'
                file_path = os.path.join(script_dir, "../", file_path)
                replace_line_in_file(file_path, match, updated_line)

remove_traling_slash = False
where_the_script_lives = pathlib.Path(__file__).parent.resolve()
print(f"Script dir: {where_the_script_lives}")
process_input_lines(sys.stdin, where_the_script_lives, remove_traling_slash)
