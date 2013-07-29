#!/bin/sh
# These are run via git-release(1) from visionmedia/git-extras
# npm
if test -f package.json; then
  # If the package.json does not contain a 'private: true', publish it
  node -e "f = './package.json'; p = require(f); process.exit(+(p.private||0))" && npm publish
fi
