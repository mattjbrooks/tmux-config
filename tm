#! /bin/bash

source ~/.bashrc

function newsession {

  if [[ -z "$1" ]] ; then
    local session_name="0"
  else
    local session_name="$1"
  fi

  tmux new-session -d -s $session_name
  tmux new-window
  tmux select-window -t 0
  tmux attach-session -t $session_name

}

if [[ $TMUX ]] ; then
  echo "tm: exiting, would lead to nested sessions"
  exit 1
fi

if [[ "$#" -gt 1 ]] ; then
  echo "usage: tm [session-name]"
  exit 1
fi

konsoleprofile colors="Vim"
tmux attach -t "$1" || newsession "$1"
