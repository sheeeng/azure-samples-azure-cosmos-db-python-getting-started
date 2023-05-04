#!/usr/bin/env bash

set -o errexit
# set -o xtrace

GIT_TOP_DIRECTORY="$(git rev-parse --show-toplevel)"
SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# ----------------------------------------------------------------------

# https://stackoverflow.com/a/31397073
# mktemp --directory "${TMPDIR:-/tmp}/zombie.XXXXXXXXX"
TEMPORARY_DIRECTORY="$(mktemp --directory --tmpdir=${PWD})"

function cleanUp {
    rm \
        --recursive \
        --verbose \
        "${TEMPORARY_DIRECTORY}"
}
trap cleanUp EXIT

# ----------------------------------------------------------------------

BG_BLACK=$(tput setab 0)
export BG_BLACK
BG_RED=$(tput setab 1)
export BG_RED
BG_GREEN=$(tput setab 2)
export BG_GREEN
BG_YELLOW=$(tput setab 3)
export BG_YELLOW
BG_BLUE=$(tput setab 4)
export BG_BLUE
BG_MAGENTA=$(tput setab 5)
export BG_MAGENTA
BG_CYAN=$(tput setab 6)
export BG_CYAN
BG_WHITE=$(tput setab 7)
export BG_WHITE

FG_BLACK=$(tput setaf 0)
export FG_BLACK
FG_RED=$(tput setaf 1)
export FG_RED
FG_GREEN=$(tput setaf 2)
export FG_GREEN
FG_YELLOW=$(tput setaf 3)
export FG_YELLOW
FG_BLUE=$(tput setaf 4)
export FG_BLUE
FG_MAGENTA=$(tput setaf 5)
export FG_MAGENTA
FG_CYAN=$(tput setaf 6)
export FG_CYAN
FG_WHITE=$(tput setaf 7)
export FG_WHITE

TX_BOLD=$(tput bold)
export TX_BOLD
TX_DIM=$(tput dim) || true
export TX_DIM
TX_UNDERLINE=$(tput smul)
export TX_UNDERLINE
TX_END_UNDERLINE=$(tput rmul)
export TX_END_UNDERLINE
TX_REVERSE=$(tput rev)
export TX_REVERSE
TX_STANDOUT=$(tput smso)
export TX_STANDOUT
TX_END_STANDOUT=$(tput rmso)
export TX_END_STANDOUT
TX_RESET=$(tput sgr0)
export TX_RESET

# ----------------------------------------------------------------------

FOREGROUND_BLACK='\e[0;30m %s \e[0m \n'
export FOREGROUND_BLACK
FOREGROUND_RED='\e[0;31m%s\e[0m\n'
export FOREGROUND_RED
FOREGROUND_GREEN='\e[0;32m%s\e[0m\n'
export FOREGROUND_GREEN
FOREGROUND_YELLOW='\e[0;33m%s\e[0m\n'
export FOREGROUND_YELLOW
FOREGROUND_BLUE='\e[0;34m%s\e[0m\n'
export FOREGROUND_BLUE
FOREGROUND_MAGENTA='\e[0;35m%s\e[0m\n'
export FOREGROUND_MAGENTA
FOREGROUND_CYAN='\e[0;36m%s\e[0m\n'
export FOREGROUND_CYAN
FOREGROUND_WHITE='\e[0;37m%s\e[0m\n'
export FOREGROUND_WHITE

BOLD_BLACK='\e[1;30m%s\e[0m\n'
export BOLD_BLACK
BOLD_RED='\e[1;31m%s\e[0m\n'
export BOLD_RED
BOLD_GREEN='\e[1;32m%s\e[0m\n'
export BOLD_GREEN
BOLD_YELLOW='\e[1;33m%s\e[0m\n'
export BOLD_YELLOW
BOLD_BLUE='\e[1;34m%s\e[0m\n'
export BOLD_BLUE
BOLD_MAGENTA='\e[1;35m%s\e[0m\n'
export BOLD_MAGENTA
BOLD_CYAN='\e[1;36m%s\e[0m\n'
export BOLD_CYAN
BOLD_WHITE='\e[1;37m%s\e[0m\n'
export BOLD_WHITE

UNDERLINE_BLACK='\e[4;30m%s\e[0m\n'
export UNDERLINE_BLACK
UNDERLINE_RED='\e[4;31m%s\e[0m\n'
export UNDERLINE_RED
UNDERLINE_GREEN='\e[4;32m%s\e[0m\n'
export UNDERLINE_GREEN
UNDERLINE_YELLOW='\e[4;33m%s\e[0m\n'
export UNDERLINE_YELLOW
UNDERLINE_BLUE='\e[4;34m%s\e[0m\n'
export UNDERLINE_BLUE
UNDERLINE_MAGENTA='\e[4;35m%s\e[0m\n'
export UNDERLINE_MAGENTA
UNDERLINE_CYAN='\e[4;36m%s\e[0m\n'
export UNDERLINE_CYAN
UNDERLINE_WHITE='\e[4;37m%s\e[0m\n'
export UNDERLINE_WHITE

BACKGROUND_BLACK="\[\033[40m\]"
export BACKGROUND_BLACK
BACKGROUND_RED="\[\033[41m\]"
export BACKGROUND_RED
BACKGROUND_GREEN="\[\033[42m\]"
export BACKGROUND_GREEN
BACKGROUND_YELLOW="\[\033[43m\]"
export BACKGROUND_YELLOW
BACKGROUND_BLUE="\[\033[44m\]"
export BACKGROUND_BLUE
BACKGROUND_PURPLE="\[\033[45m\]"
export BACKGROUND_PURPLE
BACKGROUND_CYAN="\[\033[46m\]"
export BACKGROUND_CYAN
BACKGROUND_WHITE="\[\033[47m\]"
export BACKGROUND_WHITE

# ----------------------------------------------------------------------

confirmPrompt() {
    while true; do
        read -r -n 1 -p "${1:-Continue?} [y/N]: " REPLY
        case $REPLY in
            [yY])
                echo
                return 0
                ;;
            [nN])
                echo
                return 1
                ;;
            *) return 1 ;; # printf " \033[31m %s \n\033[0m" "Enter Y, y, N, or n as valid option."
        esac
    done
}

# ----------------------------------------------------------------------

printSeparatorLine() {
    local columnWidth="${1:-72}"
    for ((i = 1; i <= columnWidth; i++)); do
        printf "${FG_MAGENTA}%s${TX_RESET}" '-'
        if [[ "${i}" -ge "${columnWidth}" ]]; then echo; fi
    done
}

# ----------------------------------------------------------------------
printSeparatorLine

cd "${TEMPORARY_DIRECTORY}"

# https://learn.microsoft.com/en-us/cli/azure/cosmosdb/sql/container?view=azure-cli-latest#az-cosmosdb-sql-container-exists
az cosmosdb sql container exists \
    --account-name "${COSMOS_DB_ACCOUNT_NAME}" \
    --database-name "${COSMOS_DB_ACCOUNT_DATABASE_NAME}" \
    --name "${COSMOS_DB_ACCOUNT_CONTAINER_NAME}" \
    --resource-group "${COSMOS_DB_ACCOUNT_RESOURCE_GROUP_NAME}"

# https://learn.microsoft.com/en-us/cli/azure/cosmosdb/sql/container?view=azure-cli-latest#az-cosmosdb-sql-container-delete
az cosmosdb sql container delete \
    --account-name "${COSMOS_DB_ACCOUNT_NAME}" \
    --database-name "${COSMOS_DB_ACCOUNT_DATABASE_NAME}" \
    --name "${COSMOS_DB_ACCOUNT_CONTAINER_NAME}" \
    --resource-group "${COSMOS_DB_ACCOUNT_RESOURCE_GROUP_NAME}" \
    --yes

# https://learn.microsoft.com/en-us/cli/azure/cosmosdb/sql/container?view=azure-cli-latest#az-cosmosdb-sql-container-create
az cosmosdb sql container create \
    --account-name "${COSMOS_DB_ACCOUNT_NAME}" \
    --database-name "${COSMOS_DB_ACCOUNT_DATABASE_NAME}" \
    --name "${COSMOS_DB_ACCOUNT_CONTAINER_NAME}" \
    --resource-group "${COSMOS_DB_ACCOUNT_RESOURCE_GROUP_NAME}" \
    --partition-key-path "${COSMOS_DB_ACCOUNT_PARTITION_KEY_PATH}"

cd "${SCRIPT_DIRECTORY}"

printSeparatorLine
