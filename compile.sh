#!/bin/bash

benchmark=$(basename "${PWD}")

# Defaults
only_langs=false

while getopts "cst:u:l:h" opt; do
  case $opt in
    l) only_langs="${OPTARG}" ;;    # Languages to benchmark, comma separated
    *) ;;
  esac
done
shift $((OPTIND-1))

if [ -n "${only_langs}" ] && [ "${only_langs}" != "false" ]; then
    IFS=',' read -r -a only_langs <<< "${only_langs}"
fi

function compile {
  local language_name=${1}
  local directory=${2}
  local compile_cmd=${3}

  if [ "$only_langs" != false ]; then
    local should_run=false
    for lang in "${only_langs[@]}"; do
      if [ "$lang" = "$language_name" ]; then
        should_run=true
        break
      fi
    done
    if [ "$should_run" = false ]; then
      return
    fi
  fi

  if [ -d ${directory} ]; then
    echo ""
    echo "Compiling ${language_name}"
    eval "${compile_cmd}"
    result=$?
    if [ $result -ne 0 ]; then
        echo "Failed to compile ${language_name} with command: ${compile_cmd}"
    fi
  fi
}

echo "Starting compiles for ${benchmark}"

source ../languages.sh
compile_languages

echo
echo "Done with compiles for ${benchmark}"
