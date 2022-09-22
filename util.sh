#!/bin/bash
set -e

# -------------------------------------------
#   constans  definitions
# -------------------------------------------
CAT_COMMAND="cat"
SHELL_COMMAND="shell"

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
  printf "\033[36m%s\033[0m %s\n" "command"
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
      cat)
        COMMAND="cat"
        shift
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

execScript() {
  script="$DIR/scripts/$SCRIPT_NAME.sh"
  if [[ -f "$script" ]]; then
    bash $script $@
  else
    panic "script is not found"
  fi
}

printScript() {
  if [[ "$COMMAND" = "$CAT_COMMAND" ]]; then
    script="$DIR/scripts/$SCRIPT_NAME.sh"
    if [[ -f "$script" ]]; then
      cat "$script"
      exit
    else
      panic "script is not found"
    fi
  fi
}

# -------------------------------------------
#   main
# -------------------------------------------

args $@
printScript
execScript
