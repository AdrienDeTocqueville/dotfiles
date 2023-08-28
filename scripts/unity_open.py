#!/usr/bin/env python3

# Arguments to setup in Unity preferences
# -p $(ProjectPath) -f $(File) -l $(Line) -c $(Column)

import sys, getopt, os, time
import db
import logging

NVIM="/opt/homebrew/bin/nvim"

logging.basicConfig(filename='/tmp/unipy.log',
                    filemode='a',
                    format='%(asctime)s %(message)s',
                    datefmt='%H:%M:%S',
                    level=logging.DEBUG)

logging.info(f"args {sys.argv[1:]}")

opts, args = getopt.getopt(sys.argv[1:], "p:f:l:c:")
line = column = None

for o, a in opts:
    if o == '-p':
        path = a
        project = os.path.basename(path)
    elif o == "-f":
        if a == '-l':
            file = None
        else:
            file=a
    elif o == "-l":
        line = a
    elif o == "-c":
        column = a

db.parse_db()

# Verify project is still valid
if project in db.DB:
    try:
        os.stat(db.DB[project])
    except FileNotFoundError:
        logging.info(f"clearing existing project...")

        db.DB.pop(project)
        db.write_db()
        pass

# Open new project
if not project in db.DB:
    logging.info(f"new project {project}...")

    project_file = f"/tmp/{project}.sh"
    f = open(project_file, "w+")
    f.write(f"#!/bin/zsh\ncd {path};SERVER={project} nvim;exit\n")
    f.close();

    os.system(f"chmod +x {project_file}; open {project_file} -a iTerm")

    while not project in db.DB:
        time.sleep(0.1)
        db.parse_db()
else:
    logging.info(f"project already open...")

# Send command
socket = db.DB[project]
cmd = ""
if file is not None:
    cmd += f":tabe {file}<CR>"
if line is not None:
    cmd += f":{line}<CR>"
if column is not None:
    cmd += f"{column}|"

logging.info(f"server {socket}")
logging.info(f"nvim {cmd}")
ret = os.system(f"{NVIM} --server {socket} --remote-send '{cmd}'")
logging.info(f"return {ret}")
