# Navigate to test directory
ORIG_PWD="$PWD"
TEST_DIR="$PWD/test"

# Move any test .git directories back to dotgit
make move-git-to-dotgit > /dev/null

fixture_dir() {
  TMP_DIR="$(mktemp -d)"
  cp -r "$TEST_DIR"/test-files/$1/* "$TMP_DIR"
  cd "$TMP_DIR"
  test -d dotgit && mv dotgit .git
}

fixture_git_init() {
  TMP_DIR="$(mktemp -d)"
  cd "$TMP_DIR"
  git init 1> /dev/null
}

# Load in bash_prompt
. .bash_prompt

# sexy_bash_prompt_is_on_git

  # in a git directory
  fixture_dir 'git'

    # has an exit code of 0
    sexy_bash_prompt_is_on_git || echo '`sexy_bash_prompt_is_on_git`; $? != 0 in git directory' 1>&2

  # in a non-git directory
  fixture_dir 'non-git'

    # has a non-zero exit code
    ! sexy_bash_prompt_is_on_git || echo '`sexy_bash_prompt_is_on_git`; $? == 0 in non-git directory' 1>&2

  # in a git-init'd directory
  # DEV: This is an edge case test discovered in 0.10.0
  # DEV: Unfortunately, I cannot upgrade to the latest version of Git so I run `git init` to get Travis CI to pass
  # fixture_dir 'git-init'
  fixture_git_init

    # has an exit code of 0
    sexy_bash_prompt_is_on_git || echo '`sexy_bash_prompt_is_on_git`; $? != 0 in git-init directory' 1>&2

# sexy_bash_prompt_get_git_branch

  # on a `master` branch
  fixture_dir 'branch-master'

    # is `master`
    test "$(sexy_bash_prompt_get_git_branch)" = "master" || echo '`sexy_bash_prompt_get_git_branch` !== `master` on a `master` branch' 1>&2

  # on `dev/test` branch
  fixture_dir 'branch-dev'

    # is `dev/test`
    test "$(sexy_bash_prompt_get_git_branch)" = "dev/test" || echo '`sexy_bash_prompt_get_git_branch` !== `dev/test` on `dev/test` branch' 1>&2

  # off of a branch
  fixture_dir 'branch-non'

    # is 'no branch'
    test "$(sexy_bash_prompt_get_git_branch)" = "(no branch)" || echo '`sexy_bash_prompt_get_git_branch` !== `(no branch)` off of a branch' 1>&2

  # in a git-init'd directory
  # DEV: This is an edge case test discovered in 0.10.0
  fixture_git_init

    # is `master`
    test "$(sexy_bash_prompt_get_git_branch)" = "master" || echo '`sexy_bash_prompt_get_git_branch` !== `master` in a `git-init` directory' 1>&2

# git_status

  # on a synced branch
  fixture_dir 'synced'

    # is nothing
    test "$(sexy_bash_prompt_get_git_status)" = "" || echo '`sexy_bash_prompt_get_git_status` !== "" on a synced branch' 1>&2

  # on a dirty synced branch
  fixture_dir 'dirty-synced'

    # is an asterisk
    test "$(sexy_bash_prompt_get_git_status)" = "*" || echo '`sexy_bash_prompt_get_git_status` !== "*" on a dirty synced branch' 1>&2

  # on an unpushed branch
  # DEV: This covers new branches (for now)
  fixture_dir 'unpushed'

    # is an empty up triangle
    test "$(sexy_bash_prompt_get_git_status)" = "△" || echo '`sexy_bash_prompt_get_git_status` !== "△" on an unpushed branch' 1>&2

  # on a dirty and unpushed branch
  fixture_dir 'dirty-unpushed'

    # is a filled up triangle
    test "$(sexy_bash_prompt_get_git_status)" = "▲" || echo '`sexy_bash_prompt_get_git_status` !== "▲" on a dirty and unpushed branch' 1>&2

  # on an unpulled branch
  fixture_dir 'unpulled'

    # is an empty down triangle
    test "$(sexy_bash_prompt_get_git_status)" = "▽" || echo '`sexy_bash_prompt_get_git_status` !== "▽" on an unpulled branch' 1>&2

  # on a dirty and unpulled branch
  fixture_dir 'dirty-unpulled'

    # is an filled down triangle
    test "$(sexy_bash_prompt_get_git_status)" = "▼" || echo '`sexy_bash_prompt_get_git_status` !== "▼" on a dirty unpulled branch' 1>&2

  # on an unpushed and unpulled branch
  fixture_dir 'unpushed-unpulled'

    # is an empty hexagon
    test "$(sexy_bash_prompt_get_git_status)" = "⬡" || echo '`sexy_bash_prompt_get_git_status` !== "⬡" on an unpushed and unpulled branch' 1>&2

  # on a dirty, unpushed, and unpulled branch
  fixture_dir 'dirty-unpushed-unpulled'

    # is an filled hexagon
    test "$(sexy_bash_prompt_get_git_status)" = "⬢" || echo '`sexy_bash_prompt_get_git_status` !== "⬢" on a dirty, unpushed, and unpulled branch' 1>&2

# git_progress

  # on a clean branch
  fixture_dir 'synced'

    # is nothing
    test "$(sexy_bash_prompt_get_git_progress)" = "" || echo '`sexy_bash_prompt_get_git_progress` !== "" on a clean branch' 1>&2

  # https://github.com/twolfson/sexy-bash-prompt/issues/25
  # on a merge-in-progress branch
  fixture_dir 'merge-in-progress'

    # shows a merge in progress
    test "$(sexy_bash_prompt_get_git_progress)" = " [merge]" || echo '`sexy_bash_prompt_get_git_progress` !== " [merge]" on a clean merge-in-progress branch' 1>&2

    # in a sub-directory
    mkdir nested
    cd nested

      # shows a merge in progress
      test "$(sexy_bash_prompt_get_git_progress)" = " [merge]" || echo '`sexy_bash_prompt_get_git_progress` !== " [merge]" in a subdirectory of a clean merge-in-progress branch' 1>&2

  # when an `am` is in progress (`git am`)
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1208-L1211
  # DEV: To reproduce, `git format-patch SHA; git checkout -; git am PATCH`
  # DEV: Research for determining this was `am` https://github.com/git/git/blob/v1.9-rc2/contrib/completion/git-prompt.sh#L339-L340
  # DEV: The empty check is for better dialog https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L919-L925
  fixture_dir 'am-in-progress'

    # shows an `am` in progress
    test "$(sexy_bash_prompt_get_git_progress)" = " [am]" || echo '`sexy_bash_prompt_get_git_progress` !== " [am]" in an am-in-progress repo' 1>&2

  # when a `git rebase` is in progress (no `--interactive` or `--merge`)
  # DEV: This is caused by `git rebase`
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1212-L1216
  fixture_dir 'rebase-in-progress'

    # shows a `rebase` in progress
    test "$(sexy_bash_prompt_get_git_progress)" = " [rebase]" || echo '`sexy_bash_prompt_get_git_progress` !== " [rebase]" in a rebase-in-progress repo' 1>&2

  # when an interactive rebase is in progress(`git rebase --interactive`)
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1218-L1219
  fixture_dir 'rebase-interactive-in-progress'

    # shows a `rebase` in progress
    test "$(sexy_bash_prompt_get_git_progress)" = " [rebase]" || echo '`sexy_bash_prompt_get_git_progress` !== " [rebase]" in a rebase-interactive-in-progress repo' 1>&2

  # when a merge based rebase is in progress (`git rebase --merge`)
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1220-L1223
  fixture_dir 'rebase-merge-in-progress'

    # shows a `rebase` in progress
    test "$(sexy_bash_prompt_get_git_progress)" = " [rebase]" || echo '`sexy_bash_prompt_get_git_progress` !== " [rebase]" in a rebase-merge-in-progress repo' 1>&2

  # on an incomplete cherry-pick
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1224-L1227
  fixture_dir 'cherry-pick-in-progress'

    # shows a `cherry-pick` in progress
    test "$(sexy_bash_prompt_get_git_progress)" = " [cherry-pick]" || echo '`sexy_bash_prompt_get_git_progress` !== " [cherry-pick]" in a cherry-pick-in-progress repo' 1>&2

  # in an incomplete bisect
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1229-L1232
  fixture_dir 'bisect-in-progress'

    # shows a `bisect` in progress
    test "$(sexy_bash_prompt_get_git_progress)" = " [bisect]" || echo '`sexy_bash_prompt_get_git_progress` !== " [bisect]" in a bisect-in-progress repo' 1>&2

  # in an incomplete revert
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1233-L1237
  # DEV: To reproduce, `git revert HEAD --no-commit`
  fixture_dir 'revert-in-progress'

    # shows a `revert` in progress
    test "$(sexy_bash_prompt_get_git_progress)" = " [revert]" || echo '`sexy_bash_prompt_get_git_progress` !== " [revert]" in a revert-in-progress repo' 1>&2

# sexy-bash-prompt
cd "$ORIG_PWD"

  # when run as a script
  prompt_output="$(bash --norc --noprofile -i -c '. .bash_prompt')"

    # does not have any output
    test ${#prompt_output} -eq 0 || echo '`prompt_output` did not have length 0' 1>&2

# sexy_bash_prompt_symbol
cd "$ORIG_PWD"

  # with a normal user
  bash_symbol="$(bash --norc --noprofile -i -c '. .bash_prompt; echo "$sexy_bash_prompt_symbol"')"

    # is $
    test "$bash_symbol" = "$" || echo '`sexy_bash_prompt_symbol` !== "$" for a normal user' 1>&2

  # with root
  if which sudo &> /dev/null; then
    bash_symbol="$(sudo bash --norc --noprofile -i -c '. .bash_prompt; echo "$sexy_bash_prompt_symbol"')";

    # is #
    test "$bash_symbol" = "#" || echo '`sexy_bash_prompt_symbol` !== "#" for root' 1>&2
  else
    echo "WARNING: sudo not found or insufficient privileges. Test skipped." 1>&2
  fi

# prompt colors
cd "$ORIG_PWD"
esc=$'\033'

  # in a 256 color terminal
  TERM=xterm-256color . .bash_prompt

    # Deprecated color by color test, not used because requires double maintenance
    # echo "$(TERM=xterm-256color tput bold)$(TERM=xterm-256color tput setaf 27)" | copy
    # test "$sexy_bash_prompt_user_color" = "$esc[1m$esc[38;5;27m" || echo '`sexy_bash_prompt_user_color` is not bold blue (256)' 1>&2

    # uses 256 color palette
    expected_prompt='\['$esc'[1m'$esc'[38;5;27m\]\u\['$esc'(B'$esc'[m\] \['$esc'[1m'$esc'[37m\]at\['$esc'(B'$esc'[m\] \['$esc'[1m'$esc'[38;5;39m\]\h\['$esc'(B'$esc'[m\] \['$esc'[1m'$esc'[37m\]in\['$esc'(B'$esc'[m\] \['$esc'[1m'$esc'[38;5;76m\]\w\['$esc'(B'$esc'[m\]$( sexy_bash_prompt_is_on_git &&   echo -n " \['$esc'[1m'$esc'[37m\]on\['$esc'(B'$esc'[m\] " &&   echo -n "\['$esc'[1m'$esc'[38;5;154m\]$(sexy_bash_prompt_get_git_info)" &&   echo -n "\['$esc'[1m'$esc'[91m\]$(sexy_bash_prompt_get_git_progress)" &&   echo -n "\['$esc'[1m'$esc'[37m\]")\n\['$esc'(B'$esc'[m\]\['$esc'[1m\]$ \['$esc'(B'$esc'[m\]'

    # DEV: To debug, use a diff tool. Don't stare at the code.
    # http://www.diffchecker.com/diff
    # To get the latest prompt, enable one of the echoes and run `make test | copy`
    # echo "$PS1"
    # echo "$expected_prompt"
    test "$PS1" = "$expected_prompt" || echo '`PS1` is not as expected (256)' 1>&2

  # in an 8 color terminal
  TERM=xterm . .bash_prompt

    # uses 8 color palette
    expected_prompt='\['$esc'[1m'$esc'[34m\]\u\['$esc'(B'$esc'[m\] \['$esc'[1m'$esc'[37m\]at\['$esc'(B'$esc'[m\] \['$esc'[1m'$esc'[36m\]\h\['$esc'(B'$esc'[m\] \['$esc'[1m'$esc'[37m\]in\['$esc'(B'$esc'[m\] \['$esc'[1m'$esc'[32m\]\w\['$esc'(B'$esc'[m\]$( sexy_bash_prompt_is_on_git &&   echo -n " \['$esc'[1m'$esc'[37m\]on\['$esc'(B'$esc'[m\] " &&   echo -n "\['$esc'[1m'$esc'[33m\]$(sexy_bash_prompt_get_git_info)" &&   echo -n "\['$esc'[1m'$esc'[31m\]$(sexy_bash_prompt_get_git_progress)" &&   echo -n "\['$esc'[1m'$esc'[37m\]")\n\['$esc'(B'$esc'[m\]\['$esc'[1m\]$ \['$esc'(B'$esc'[m\]'
    test "$PS1" = "$expected_prompt" || echo '`PS1` is not as expected (8)' 1>&2

  # in an ANSI terminal
  TERM="" . .bash_prompt

    # uses ANSI colors
    expected_prompt='\[\033[1;34m\]\u\[\033[m\] \[\033[1;37m\]at\[\033[m\] \[\033[1;36m\]\h\[\033[m\] \[\033[1;37m\]in\[\033[m\] \[\033[1;32m\]\w\[\033[m\]$( sexy_bash_prompt_is_on_git &&   echo -n " \[\033[1;37m\]on\[\033[m\] " &&   echo -n "\[\033[1;33m\]$(sexy_bash_prompt_get_git_info)" &&   echo -n "\[\033[1;31m\]$(sexy_bash_prompt_get_git_progress)" &&   echo -n "\[\033[1;37m\]")\n\[\033[m\]\[\]$ \[\033[m\]'
    test "$PS1" = "$expected_prompt" || echo '`PS1` is not as expected (ANSI)' 1>&2

  # when overridden
  TERM=xterm-256color PROMPT_USER_COLOR='\033[1;32m' \
    PROMPT_PREPOSITION_COLOR='\033[1;33m' PROMPT_DEVICE_COLOR='\033[1;34m' \
    PROMPT_DIR_COLOR='\033[1;35m' PROMPT_GIT_STATUS_COLOR='\033[1;36m'  \
    PROMPT_GIT_PROGRESS_COLOR='\033[1;37m' PROMPT_SYMBOL_COLOR='\033[1;38m' \
    . .bash_prompt

    # use the new colors
    expected_prompt='\[\033[1;32m\]\u\['$esc'(B'$esc'[m\] \[\033[1;33m\]at\['$esc'(B'$esc'[m\] \[\033[1;34m\]\h\['$esc'(B'$esc'[m\] \[\033[1;33m\]in\['$esc'(B'$esc'[m\] \[\033[1;35m\]\w\['$esc'(B'$esc'[m\]$( sexy_bash_prompt_is_on_git &&   echo -n " \[\033[1;33m\]on\['$esc'(B'$esc'[m\] " &&   echo -n "\[\033[1;36m\]$(sexy_bash_prompt_get_git_info)" &&   echo -n "\[\033[1;37m\]$(sexy_bash_prompt_get_git_progress)" &&   echo -n "\[\033[1;33m\]")\n\['$esc'(B'$esc'[m\]\[\033[1;38m\]$ \['$esc'(B'$esc'[m\]'
    test "$PS1" = "$expected_prompt" || echo '`PS1` is not as expected (overridden)' 1>&2

# prompt status symbols
  # when overridden
  PROMPT_SYNCED_SYMBOL='#synced' PROMPT_DIRTY_SYNCED_SYMBOL='#dirty-synced' \
    PROMPT_UNPUSHED_SYMBOL='#unpushed' PROMPT_DIRTY_UNPUSHED_SYMBOL='#dirty-unpushed' \
    PROMPT_UNPULLED_SYMBOL='#unpulled' PROMPT_DIRTY_UNPULLED_SYMBOL='#dirty-unpulled' \
    PROMPT_UNPUSHED_UNPULLED_SYMBOL='#unpushed-unpulled' PROMPT_DIRTY_UNPUSHED_UNPULLED_SYMBOL='#dirty-unpushed-unpulled' \
    PROMPT_SYMBOL='#prompt-symbol' \
    . .bash_prompt

    # the prompt always uses the PROMPT_SYMBOL
    test "$sexy_bash_prompt_symbol" = "#prompt-symbol" || echo 'sexy_bash_prompt_symbol was not overridden by PROMPT_SYMBOL as expected' 1>&2

    # a synced prompt uses the new symbol
    fixture_dir 'synced'
    test "$(sexy_bash_prompt_get_git_status)" = "#synced" || echo '`sexy_bash_prompt_get_git_status` !== "#synced" on an overridden synced branch' 1>&2

    # a dirty synced prompt uses the new symbol
    fixture_dir 'dirty-synced'
    test "$(sexy_bash_prompt_get_git_status)" = "#dirty-synced" || echo '`sexy_bash_prompt_get_git_status` !== "#dirty-synced" on an overridden dirty synced branch' 1>&2

    # an unpushed prompt uses the new symbol
    fixture_dir 'unpushed'
    test "$(sexy_bash_prompt_get_git_status)" = "#unpushed" || echo '`sexy_bash_prompt_get_git_status` !== "#unpushed" on an overridden and unpushed branch' 1>&2

    # a dirty and unpushed prompt uses the new symbol
    fixture_dir 'dirty-unpushed'
    test "$(sexy_bash_prompt_get_git_status)" = "#dirty-unpushed" || echo '`sexy_bash_prompt_get_git_status` !== "#dirty-unpushed" on an overridden, dirty, and unpushed branch' 1>&2

    # an unpulled prompt uses the new symbol
    fixture_dir 'unpulled'
    test "$(sexy_bash_prompt_get_git_status)" = "#unpulled" || echo '`sexy_bash_prompt_get_git_status` !== "#unpulled" on an overridden and unpulled branch' 1>&2

    # a dirty and unpulled prompt uses the new symbol
    fixture_dir 'dirty-unpulled'
    test "$(sexy_bash_prompt_get_git_status)" = "#dirty-unpulled" || echo '`sexy_bash_prompt_get_git_status` !== "#dirty-unpulled" on an overridden, dirty, and unpulled branch' 1>&2

    # an unpushed and unpushed prompt uses the new symbol
    fixture_dir 'unpushed-unpulled'
    test "$(sexy_bash_prompt_get_git_status)" = "#unpushed-unpulled" || echo '`sexy_bash_prompt_get_git_status` !== "#unpushed-unpulled" on an overridden, unpushed, and unpulled branch' 1>&2

    # a dirty, unpushed, and unpushed prompt uses the new symbol
    fixture_dir 'dirty-unpushed-unpulled'
    test "$(sexy_bash_prompt_get_git_status)" = "#dirty-unpushed-unpulled" || echo '`sexy_bash_prompt_get_git_status` !== "#dirty-unpushed-unpulled" on an overridden, dirty, unpushed, and unpulled branch' 1>&2
