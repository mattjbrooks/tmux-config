#! /bin/bash

source ~/.bashrc

function newsession {
  # return if we are already in a tmux session
  if [[ $TMUX ]] ; then
    return 0
  fi

  if [[ -z "$1" ]] ; then
    local session_name="0"
  else
    local session_name="$1"
  fi

  tmux new-session -d -s $session_name
  tmux select-window -t $session_name
  
  tmux split-window -h -p 50 -t $session_name

  tmux select-pane -t 0
  tmux resize-pane -Z
  tmux attach-session -t $session_name
}

if [[ "$#" -gt 1 ]] ; then
  echo "usage: tm [session-name]"
  exit 1
fi

konsoleprofile colors="Vim"
tmux attach -t "$1" || newsession "$1"
