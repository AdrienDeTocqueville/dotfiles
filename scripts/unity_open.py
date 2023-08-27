#!/usr/bin/env python3

import sys, getopt, os
import db

opts, args = getopt.getopt(sys.argv[1:], "p:f:l:")

project=""
file=""
line="0"

for o, a in opts:
    if o == '-p':
        path = a
    elif o == "-f":
        if a == '-l':
            file = "..."
        else:
            file=a
    elif o == "-l":
        line = a

socket = db.DB["rp"]

cmd = ":tabe " + file + "<CR>:" + line + "<CR>"
cmd = "nvim --server " + socket + " --remote-send '" + cmd + "'"
print(cmd)
