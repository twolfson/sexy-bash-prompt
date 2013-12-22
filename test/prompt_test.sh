# Navigate to test directory
ORIG_PWD=$PWD
TEST_DIR=$PWD/test

# Move any test .git directories back to dotgit
make move-git-to-dotgit > /dev/null

fixture_dir() {
  TMP_DIR=$(mktemp -d)
  cp -r "$TEST_DIR"/test-files/$1/* $TMP_DIR
  cd $TMP_DIR
  test -d dotgit && mv dotgit .git
}

fixture_git_init() {
  TMP_DIR=$(mktemp -d)
  cd $TMP_DIR
  git init 1> /dev/null
}

# Load in bash_prompt
. .bash_prompt

# is_on_git

  # in a git directory
  fixture_dir 'git'

    # has an exit code of 0
    is_on_git || echo '`is_on_git`; $? != 0 in git directory' 1>&2

  # in a non-git directory
  fixture_dir 'non-git'

    # has a non-zero exit code
    ! is_on_git || echo '`is_on_git`; $? == 0 in non-git directory' 1>&2

  # in a git-init'd directory
  # DEV: This is an edge case test discovered in 0.10.0
  # DEV: Unfortunately, I cannot upgrade to the latest version of Git so I run `git init` to get Travis CI to pass
  # fixture_dir 'git-init'
  fixture_git_init

    # has an exit code of 0
    is_on_git || echo '`is_on_git`; $? != 0 in git-init directory' 1>&2

# get_git_branch

  # on a `master` branch
  fixture_dir 'branch-master'

    # is `master`
    test "$(get_git_branch)" = "master" || echo '`get_git_branch` !== `master` on a `master` branch' 1>&2

  # on `dev/test` branch
  fixture_dir 'branch-dev'

    # is `dev/test`
    test "$(get_git_branch)" = "dev/test" || echo '`get_git_branch` !== `dev/test` on `dev/test` branch' 1>&2

  # off of a branch
  fixture_dir 'branch-non'

    # is 'no branch'
    test "$(get_git_branch)" = "(no branch)" || echo '`get_git_branch` !== `(no branch)` off of a branch' 1>&2

  # in a git-init'd directory
  # DEV: This is an edge case test discovered in 0.10.0
  fixture_git_init

    # is `master`
    test "$(get_git_branch)" = "master" || echo '`get_git_branch` !== `master` in a `git-init` directory' 1>&2

# git_status

  # on a clean and synced branch
  fixture_dir 'clean-synced'

    # is nothing
    test "$(get_git_status)" = "" || echo '`get_git_status` !== "" on a clean and synced branch' 1>&2

  # on a dirty branch
  fixture_dir 'dirty'

    # is an asterisk
    test "$(get_git_status)" = "*" || echo '`get_git_status` !== "*" on a dirty branch' 1>&2

  # on an unpushed branch
  # DEV: This covers new branches (for now)
  fixture_dir 'unpushed'

    # is an empty up triangle
    test "$(get_git_status)" = "△" || echo '`get_git_status` !== "△" on an unpushed branch' 1>&2

  # on a dirty and unpushed branch
  fixture_dir 'dirty-unpushed'

    # is a filled up triangle
    test "$(get_git_status)" = "▲" || echo '`get_git_status` !== "▲" on a dirty and unpushed branch' 1>&2

  # on an unpulled branch
  fixture_dir 'unpulled'

    # is an empty down triangle
    test "$(get_git_status)" = "▽" || echo '`get_git_status` !== "▽" on an unpulled branch' 1>&2

  # on a dirty and unpulled branch
  fixture_dir 'dirty-unpulled'

    # is an filled down triangle
    test "$(get_git_status)" = "▼" || echo '`get_git_status` !== "▼" on a dirty unpulled branch' 1>&2

  # on an unpushed and an unpulled branch
  fixture_dir 'unpushed-unpulled'

    # is an empty hexagon
    test "$(get_git_status)" = "⬡" || echo '`get_git_status` !== "⬡" on an unpushed and unpulled branch' 1>&2

  # on a dirty, unpushed, and unpulled branch
  fixture_dir 'dirty-unpushed-unpulled'

    # is an filled hexagon
    test "$(get_git_status)" = "⬢" || echo '`get_git_status` !== "⬢" on a dirty, unpushed, and unpulled branch' 1>&2

# sexy-bash-prompt
cd $ORIG_PWD

  # when run as a script
  prompt_output="$(bash --norc --noprofile -i -c '. .bash_prompt')"

    # does not have any output
    test ${#prompt_output} -eq 0 || echo '`prompt_output` did not have length 0' 1>&2

# get_prompt_symbol
cd $ORIG_PWD

  # with a normal user
  bash_symbol="$(bash --norc --noprofile -i -c '. .bash_prompt; echo $(get_prompt_symbol)')"

    # is $
    test "$bash_symbol" = "$" || echo '`get_prompt_symbol` !== "$" for a normal user' 1>&2

  # with root
  bash_symbol="$(sudo bash --norc --noprofile -i -c '. .bash_prompt; echo $(get_prompt_symbol)')"

    # is #
    test "$bash_symbol" = "#" || echo '`get_prompt_symbol` !== "#" for root' 1>&2

# prompt colors

  # in a 256 color terminal
  cd $ORIG_PWD
  TERM=xterm-256color . .bash_prompt
  fixture_dir 'branch-master'

    # uses 256 color pallete
    expected_prompt = "\[\033[1m\033[38;5;27m\]\u\[\033(B\033[m\] \[\033[1m\033[37m\]at\[\033(B\033[m\] \[\033[1m\033[38;5;39m\]\h\[\033(B\033[m\] \[\033[1m\033[37m\]in\[\033(B\033[m\] \[\033[1m\033[38;5;76m\]\w\[\033(B\033[m\]$( is_on_git &&   echo -n " \[\033[1m\033[37m\]on\[\033(B\n\033[m\] " &&   echo -n "\[\033[1m\033[38;5;154m\]$(get_git_info)" &&   echo -n "\[\033[1m\033[37m\]")\n\[\033(B\033[m\]\[\033[1m\]$ \[\033(B\033[m\]"
    test "$expected_prompt" = "$PS1" || echo 'In a 256 color terminal, 256 colors test are out of sync with code'

  # in an 8 color terminal

    # uses 8 color pallete

  # in an ANSI terminal

    # uses ANSI colors

  # when overridden

    # use the new colors