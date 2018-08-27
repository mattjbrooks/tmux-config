#! /bin/bash

if [[ $TMUX ]] ; then
  echo -n "kill session (Y/n)? "
  read answer
  if [ "$answer" == "Y" ]; then
    tmux kill-session
  fi
else
  echo -e "Not in tmux session"
fi
