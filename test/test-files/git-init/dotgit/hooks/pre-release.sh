#!/bin/sh
# These are run via git-release(1) from visionmedia/git-extras
# npm
if test -f package.json; then
  node -e "f = './package.json'; p = require(f); p.version = process.argv[1]; require('fs').writeFileSync(f, JSON.stringify(p, null, 2));" $2

  # If there is a build script, run it
  node -e "f = './package.json'; p = require(f); process.exit(+(!p.scripts.build))" && npm run build
fi

# bower
if test -f bower.json; then
  node -e "f = './bower.json'; p = require(f); p.version = process.argv[1]; require('fs').writeFileSync(f, JSON.stringify(p, null, 2));" $2
fi

# component
if test -f component.json; then
  node -e "f = './component.json'; p = require(f); p.version = process.argv[1]; require('fs').writeFileSync(f, JSON.stringify(p, null, 2));" $2
fi

# Sublime Package Control
if test -f packages.json; then
  node -e "f = './packages.json'; p = require(f); pkg = p.packages[0]; pkg.last_modified = new Date().toISOString().replace('T', ' ').replace(/\.\d{3}Z/, ''); plat = pkg.platforms['*'][0]; v = process.argv[1]; plat.version = v; plat.url = plat.url.replace(/\d+.\d+.\d+$/, v); require('fs').writeFileSync(f, JSON.stringify(p, null, 2));" $2
fi
