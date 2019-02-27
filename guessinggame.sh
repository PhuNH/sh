#!/usr/bin/env bash
function guessing {
  local correct=0
  while [[ correct -eq 0 ]]
  do
    read -p "Guess the number of files in the current directory: " guess
    if [[ $guess -gt $1 ]]
    then
      echo "Your guess is too high"
    elif [[ $guess -lt $1 ]]
    then
      echo "Your guess is too low"
    else
      echo "Congratulations!"
      correct=1
    fi
  done
}

count=$(ls -1 | wc -l)
guessing $count
