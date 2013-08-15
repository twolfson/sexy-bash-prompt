# sexy-bash-prompt changelog
0.11.0 - Robustified `make install` to handle .bashrc not being auto-invoked

0.10.6 - Added testing against multiple `git` versions

0.10.5 - Patched `get_git_branch` to allow compatibility with earlier Git versions

0.10.4 - Added Support section to README

0.10.3 - Updated donation section to use larger badge

0.10.2 - Updates to test suite to get `git init` tests passing in Travis CI (problems between `git` versions)

0.10.1 - Fixed edge case for `get_git_branch` with `git-init` directories and tested edge case for `is_on_git` with `git-init` directories

0.10.0 - Cleaned up code via reddit's LukeShu's suggestions and added Travis CI

0.9.0 - Moved `demo` script into `Makefile` and updated screenshot to include `non-git` state

0.8.0 - Renamed `.bashrc` to `.bash_prompt` for semantic reasons

0.7.0 - DRYed up source code to make use same function for ahead/behind

0.6.0 - Namespaced colors, trimmed comments, and filled out README

0.5.0 - Moved majority of bash commands to `Makefile`

0.4.0 - Added `install.sh` for simplified setup

0.3.0 - Updated colors to be consistent between sections

0.2.0 - Introducing latest content from (e.g. prompt updates, tests)

0.1.0 - Forked from https://gist.github.com/gf3/306785/a35d28b6bdd0f7c54318cce510738438f04dabaa
