#!/bin/sh
# These are run via git-release(1) from visionmedia/git-extras
if test -f package.json; then
  npm publish
fi
