#!/usr/bin/env python3

# Arguments to setup in Unity preferences
# -p $(ProjectPath) -f $(File) -l $(Line) -c $(Column)

# test command
# ./unity_open.py -p /Users/adrien/source/projects/test_trunk -f /Users/adrien/source/unity/Packages/com.unity.render-pipelines.high-definition/Editor/AssemblyInfo.cs -l 2 -c 2; cat /tmp/unipy.log

import sys, getopt, os, time, json
import logging

NVIM="/opt/homebrew/bin/nvim"

PROJECT_FILE = """#!/bin/zsh
rm -rf /tmp/{project}/links
mkdir -p /tmp/{project}/links
{symlinks}
cd {path}
echo -n -e "\033]0;{project} - Unity\007"
touch {session_file}
UNITY_PROJ={project} nvim -S {session_file} --listen {vim_socket}
exit
"""

#UNITY_PROJ={project} GIT_DIR={git_dir} nvim -S {session_file} --listen {vim_socket}

VIMRC = """
let g:ctrlp_user_command = 'rg -L --ignore-file ~/.ignore --files /tmp/{project}/links'
let g:ctrlp_follow_symlinks=1
command! -nargs=+ Grep execute 'silent grep! "<args>" /tmp/{project}/links' | botright cope
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ -L
set expandtab tabstop=4 foldmarker={{,}} foldmethod=marker foldlevelstart=99 foldlevel=99
set path+={git_dir}
au BufEnter *.cs :call OmniTags()
au BufLeave *.cs :call DefaultTags()
function! OmniTags()
    nnoremap <F1>  :OmniSharpFindUsages<CR>
    nnoremap <F2>  :OmniSharpGotoDefinition<CR>
    nnoremap <F14>  :OmniSharpPreviewDefinition<CR>
    nnoremap <F3>  :sp<CR>:OmniSharpGotoDefinition<CR>
    nnoremap <F15> :vsp<CR>:OmniSharpGotoDefinition<CR>
    nnoremap <F4>  :tab split<CR>:OmniSharpGotoDefinition<CR>
    inoremap <C-n> <C-x><C-o>
endfun
autocmd VimLeavePre * :call DeleteHiddenBuffers()
autocmd VimLeavePre * mksession! {session_file}
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
def find_path(packages):
    path = packages["com.unity.render-pipelines.core"].split(':')
    if path[0] == "file":
        return os.path.dirname(os.path.dirname(path[1]))
    return ""
def file_exists(path):
    try:
        os.stat(vim_socket)
        return True
    except FileNotFoundError:
        return False

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

vim_socket = f"/tmp/{project}/socket"
project_file = f"/tmp/{project}/init.sh"
session_file = f"/tmp/{project}/session.vim"

# Verify if project is open or create it
if file_exists(vim_socket):
    logging.info("project already open...")
else:
    logging.info(f"creating project {project}...")

    symlinks = create_symlink(path + "/Assets", "Assets");

    f = open(path + "/Packages/manifest.json")
    packages = json.load(f)['dependencies']
    symlinks += try_add_package(packages, "com.unity.render-pipelines.core")
    symlinks += try_add_package(packages, "com.unity.render-pipelines.high-definition")
    f.close()

    git_dir = find_path(packages)

    os.system(f"mkdir -p /tmp/{project}")

    f = open(project_file, "w+")
    f.write(PROJECT_FILE.format(path=path, project=project, session_file=session_file, git_dir=git_dir, symlinks=symlinks, vim_socket=vim_socket))
    f.close();
    f = open(f"/tmp/{project}/vimrc", "w+")
    f.write(VIMRC.format(project=project, session_file=session_file, path=path, git_dir=git_dir))
    f.close();

    os.system(f"chmod +x {project_file}; open {project_file} -a iTerm")

    # Give some time to vim
    while not file_exists(vim_socket):
        time.sleep(0.1)

# Send command
cmd = ""
if file is not None:
    file = file.replace(' ','\ ')
    cmd += f":tab drop {file}<CR>"
if line is not None:
    cmd += f":{line}<CR>zz"
if column is not None:
    cmd += f"{column}|"

cmd = f"{NVIM} --server {vim_socket} --remote-send '{cmd}'"
ret = os.system(cmd)

logging.info(f"{cmd}")
logging.info(f"return {ret}")
