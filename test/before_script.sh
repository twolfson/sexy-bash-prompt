#!/usr/bin/env bash

# If were are not using `git@1.8`
if [[ "$GIT_PPA" != "ppa:git-core/v1.8" ]]; then
  # then use the Ubuntu one
  sudo apt-get install ppa-purge -y
  sudo ppa-purge "ppa:ppa:git-core/v1.8" -y
fi
