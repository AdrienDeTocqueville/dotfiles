#!/usr/bin/env python3

# Arguments to setup in Unity preferences
# -p $(ProjectPath) -f $(File) -l $(Line) -c $(Column)

import sys, getopt, os, time
import json, db
import logging

NVIM="/opt/homebrew/bin/nvim"

logging.basicConfig(filename='/tmp/unipy.log',
                    filemode='w',
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

PROJECT_FILE = """#!/bin/zsh
rm -rf /tmp/{project}/links
mkdir -p /tmp/{project}/links
{symlinks}
cd {path}
echo -n -e "\033]0;{project} - Unity\007"
touch {session_file}
UNITY_PROJ={project} nvim -S {session_file}
exit
"""

VIMRC = """
silent exec '!python3 ~/.vim/db.py {project} open ' . serverlist()[0]
let g:ctrlp_user_command = 'rg -L --files /tmp/{project}/links'
let g:ctrlp_follow_symlinks=1
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set expandtab tabstop=4 foldmarker={{,}} foldmethod=marker foldlevelstart=99 foldlevel=99
au FileType hlsl set includeexpr=substitute(v:fname,'Packages','..','g')
autocmd VimLeavePre * exec '!python3 ~/.vim/db.py {project} close'
autocmd VimLeavePre * call DeleteHiddenBuffers()
autocmd VimLeavePre mksession! {session_file}
"""

def create_symlink(src, dst):
    return f"\nln -sf {src}/ /tmp/{project}/links/{dst}"
def try_add_package(packages, name):
    if not name in packages:
        return ""
    path = packages[name].split(':')
    if path[0] == "file":
        return create_symlink(path[1], name)
    return ""

# Open new project
if not project in db.DB:
    logging.info(f"parsing manifest...")

    symlinks = create_symlink(path + "/Assets", "Assets");

    f = open(path + "/Packages/manifest.json")
    packages = json.load(f)['dependencies']
    symlinks += try_add_package(packages, "com.unity.render-pipelines.core")
    symlinks += try_add_package(packages, "com.unity.render-pipelines.high-definition")
    f.close()

    logging.info(f"new project {project}...")
    os.system(f"mkdir -p /tmp/{project}")

    project_file = f"/tmp/{project}/init.sh"
    session_file = f"/tmp/{project}/session.vim"

    f = open(project_file, "w+")
    f.write(PROJECT_FILE.format(path=path, project=project, session_file=session_file, symlinks=symlinks))
    f.close();
    f = open(f"/tmp/{project}/vimrc", "w+")
    f.write(VIMRC.format(project=project, session_file=session_file, path=path))
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
    cmd += f":tab drop {file}<CR>"
if line is not None:
    cmd += f":{line}<CR>"
if column is not None:
    cmd += f"{column}|"

logging.info(f"server {socket}")
logging.info(f"nvim {cmd}")
ret = os.system(f"{NVIM} --server {socket} --remote-send '{cmd}'")
logging.info(f"return {ret}")
