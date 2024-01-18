#!/bin/bash
# Get Git user name and email from environment variables
if [[ ! -z "$GIT_USERNAME" ]]; then
    git config --global user.name "$GIT_USERNAME"
fi
if [[ ! -z "$GIT_EMAIL" ]]; then
    git config --global user.email "$GIT_EMAIL"
fi

if [ "$1" = 'zsh' ]; then
    exec "$@"
else
    exec zsh "$@"
fi
