#! /bin/bash

# Open a tmux session named matt,
# or reattach if session already exists.

source ~/.bashrc

function setcolorscheme {
  local default="Vim"
  local alternate="WhiteOnBlack"
  local arg

  for arg in "$@"
  do
    # Optional -a flag to use alternate colorscheme
    if [ "$arg" == "-a" ] ; then
      konsoleprofile colors=$alternate
      return 0
    fi
  done
  konsoleprofile colors=$default
}

function newsession {
  # return if we are already in a tmux session
  if [ $TMUX ] ; then
    return 0
  fi

  local panes=2 # default to 2 panes
  local arg

  # Optional -1 or -3 flag to set different num of panes
  for arg in "$@"
  do
    case "$arg" in
      -1)
        local panes=1
        ;;
      -3)
        local panes=3
        ;;
    esac
  done

  # if num of cols < 158 reduce right panes to 42% horizontally
  if [ $(tput cols) -lt 158 ] ; then
    local size=42
  else
    local size=50
  fi

  tmux new-session -d -s matt
  tmux select-window -t matt
  # If $panes > 1 then split window into 2 horizontally adjacent panes
  if [ $panes -gt 1 ] ; then
    tmux split-window -h -p $size -t matt
  fi
  # If $panes > 2 then split right pane into 2 vertically adjacent panes
  if [ $panes -gt 2 ] ; then
    tmux split-window -v -p 50 -t matt
  fi
  tmux select-pane -t 0
  tmux attach-session -t matt
}

setcolorscheme $1 $2
tmux attach -t matt || newsession $1 $2
