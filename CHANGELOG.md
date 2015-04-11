# sexy-bash-prompt changelog
0.25.0 - Added support for overriding prompt symbol via `PROMPT_SYMBOL`. Via @rpdelaney in #53

0.24.2 - Moved from gratipay-badge to text prompt for support

0.24.1 - Added low level symbol suggestions to README

0.24.0 - Prefixed all local variables and functions with `sexy_bash_prompt_` via @luizfb in #40 and @twolfson in #44

0.23.0 - Added support for symbol overrides

0.22.0 - Lowercased install script variables and moved to `.bash` extension. Via @rpdelaney in #37

0.21.2 - Fixed up Travis CI PPA issues and started testing against `git@2.x.x`

0.21.1 - Added `sudo` check inside of tests via @rpdelaney in #34

0.21.0 - Added remaining 'in progress' keywords (e.g. `rebase`, `cherry-pick`)

0.20.0 - Added missing quotes and made quote style consistent

0.19.0 - Added `[merge]` indicator when a merge is in progress

0.18.0 - Added conservative check for .bashrc in profile script during install

0.17.0 - Updated install script to check against interactive shell. Fixes #24

0.16.2 - Added regression test for colors and color overrides

0.16.1 - Fixed git status color for non-256 color terminals

0.16.0 - Added ability to override colors via global PROMPT_ variables

0.15.0 - Converted all UPPER_CASE variable names to lower_case

0.14.0 - Added `#` as prompt symbol for root

0.13.0 - Adjusted color comments and DRYed up colors

0.12.0 - Removed `TERM` setting from .bash_prompt and fixed up colors for low-fi terminals

0.11.0 - Robustified `make install` to handle .bashrc not being auto-invoked

0.10.7 - Added FAQ section and information on prompt not appearing in new shells

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
