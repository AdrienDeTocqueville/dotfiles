#!/usr/bin/env python3

import sys, os

FILE=os.path.expanduser('~') + "/.vim/db"
SEPARATOR=":"
DB = {}

def parse_db():
    f = open(FILE, "r")
    for line in f:
        x = line.rstrip().split(SEPARATOR)
        DB[x[0]] = x[1]

def write_db():
    f = open(FILE, "w+")
    for key, value in DB.items():
        f.write(key + SEPARATOR + value + '\n')

try:
    parse_db()
except FileNotFoundError:
    DB = {}

if __name__ == "__main__":
    name=sys.argv[1]

    if len(sys.argv) >= 3:
        if sys.argv[2] == "open":
            DB[name] = sys.argv[3]
        elif sys.argv[2] == "close":
            DB.pop(name)
        write_db()
    elif name in DB:
        print(DB[name])
    elif name == "print":
        print(DB)
