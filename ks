#! /bin/bash

echo -n "kill session (Y/n)? "
read answer
if [ "$answer" == "Y" ]; then
  tmux kill-session
fi
