#!/bin/bash
set -e

# -------------------------------------------
#   constans  definitions
# -------------------------------------------
CAT_COMMAND="cat"
SHELL_COMMAND="shell"
UPDATE_COMMAND="update"
SEARCH_COMMAND="search"

# -------------------------------------------
#   variables  definitions
# -------------------------------------------
DIR="$( cd "$( dirname "$0" )" && pwd -P )"
DIR="$(ls -la $DIR/util | awk '{print $11}' | xargs dirname)"
SCRIPT_NAME=""
COMMAND="$SHELL_COMMAND"

# -------------------------------------------
#   functions  definitions
# -------------------------------------------
# help print help
help() {
  printf "\033[36m%s\033[0m %s\n" "util [ RootCommand | Command ]"
  echo

  printf "\033[36m%s\033[0m %s\n" "RootCommand"
  printf "  \033[36m%-30s\033[0m %s\n" "cat [ Command ]" "cat script"
  printf "  \033[36m%-30s\033[0m %s\n" "update" "update all script"
  printf "  \033[36m%-30s\033[0m %s\n" "search" "serach script & exec script"
  echo

  printf "\033[36m%s\033[0m %s\n" "Command"
  ls $DIR/scripts | grep -o "^[^\.]*" | while read line; do
    printf "  \033[36m%-30s\033[0m %s\n" "$line" "$(head "$DIR/scripts/$line.sh" -n 2 | tail -n 1 | awk 'BEGIN {FS = "# "}; {print $2}')"
  done
}

# end exit and print help
end() {
  help
  exit
}

# panic exit and print help and print error message
panic() {
  echo "" >&2
  printf '\033[31mpanic: %s\033[m\n' "$1" >&2
  end
}

# invalidArguments exit because arguments is invalid
invalidArguments() {
  panic "arguments is invalid."
}

# args read args
args() {
  if [[ "$1" = "" ]]; then
    invalidArguments
  fi

  while [ 1 ]
  do
    case $1 in
      update)
        COMMAND="$UPDATE_COMMAND"
        break
        ;;
      cat)
        COMMAND="$CAT_COMMAND"
        SCRIPT_NAME="$2"
        break
        ;;
      serach)
        COMMAND="$SEARCH_COMMAND"
        break
        ;;
      help)
        end
        ;;
      --help)
        end
        ;;
      -h)
        end
        ;;
      *)
        SCRIPT_NAME="$1"
        shift
        break
        ;;
    esac
  done
}

# execScript execute script
execScript() {
  script="$DIR/scripts/$SCRIPT_NAME.sh"
  if [[ -f "$script" ]]; then
    bash $script $@
  else
    panic "script is not found"
  fi
}

# printScript print script
printScript() {
  if [[ "$COMMAND" = "$CAT_COMMAND" ]]; then
    script="$DIR/scripts/$SCRIPT_NAME.sh"
    if [[ -f "$script" ]]; then
      cat "$script"
      exit
    fi
    panic "script is not found"
  fi
}

# update update script
update() {
  if [[ "$COMMAND" = "$UPDATE_COMMAND" ]]; then
    git pull
    exit
  fi
}

# serach serach script
search() {
  if [[ "$COMMAND" = "$SEARCH_COMMAND" ]]; then
    if [ -z "$(which fzf)" ]; then
      git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
      ~/.fzf/install
    fi
    SCRIPT_NAME=$(ls $DIR/scripts | fzf | grep -o "^[^\.]*")
  fi
}


# -------------------------------------------
#   main
# -------------------------------------------

args $@
search
update
printScript
execScript
