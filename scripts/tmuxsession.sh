#!/bin/bash

# -------------------------------------------------------
#  Create a tmux session with a set of pre‑configured windows
#  and panes.  All paths are built relative to the current
#  working directory (or an explicit directory argument).
# -------------------------------------------------------

set -euo pipefail   # safer Bash

# ------------------- functions 
function helperText() {
    printf 'Usage:\n'
    printf 'tmuxsession.sh\n'
    printf 'if theres any existing sessions, attach that, if not creates a new session\n\n'
    printf 'tmuxsession.sh -f\n'
    printf 'kills any existing session and creates a new session\n\n'
    printf 'tmuxsession.sh -h\n'
    printf 'displays this help text\n\n'
}

#   Function that creates a new window (and a split pane) in a
#   tmux session.
#
#   Arguments:
#     $1  session name  (string,  required)
#     $2  pane id       (integer, required, the window number)
#     $3  name          (string,  required, window title)
#     $4  directory     (string,  optional, defaults to $PWD)
function newTmuxWindow() {

    (( $# >= 3 )) || {
       printf 'Error: %s needs 3 or 4 arguments.\n' "$FUNCNAME" >&2
       printf 'Usage: %s <session> <paneId> <name> [<directory>]\n' "$FUNCNAME" >&2
       return 2
    }
    local SESSION=$1
    local PANEID=$2
    local NAME=$3
    local DIRECTORY=${4:-"$PWD"}


    tmux new-window -t "${SESSION}:${PANEID}" -n "$NAME" -c "$DIRECTORY"
    tmux split-window -t "${SESSION}:${PANEID}"  -v -l 15% -c "$DIRECTORY"
}

# ------------------- code

SESSION="develop"
FORCE="false"

if [[ $# -ge 1 ]]; then
    case $1 in
        -h ) helperText 
            exit 0 ;;
        -f ) FORCE="true" ;;
        *  ) helperText 
            exit 1 ;;

    esac
fi

if tmux has-session -t "$SESSION" 2>/dev/null; then

    if [[ "$FORCE" == "true" ]]; then
        tmux kill-session -t "$SESSION"
    else 
        # Session already exists – just attach to it and quit
        exec tmux attach-session -t "${SESSION}"
    fi
fi


tmux new-session -d -c "$PWD" -s "$SESSION" -n "doodles"


REPOPATH="Documents/repos"

RORWSPATH="$REPOPATH/ror-ws"
RORPATH="$RORWSPATH/ror"
newTmuxWindow "$SESSION" 2 "ror" "$RORPATH"

RORAPIPATH="$RORWSPATH/ror-api"
newTmuxWindow "$SESSION" 3 "ror-api" "$RORAPIPATH"

RORWEBPATH="$REPOPATH/ror-webapp"
newTmuxWindow "$SESSION" 4 "ror-webapp" "$RORWEBPATH"

# newTmuxWindow "$SESSION" 5 "doodles" 

tmux select-window -t "$SESSION:1"
tmux attach-session -t "$SESSION"
