# Navigate to test directory
TEST_DIR=$PWD/test

# Move any test .git directories back to dotgit
make move-git-to-dotgit > /dev/null

fixture_dir() {
  TMP_DIR=$(mktemp -d)
  cp -r "$TEST_DIR"/test-files/$1/* $TMP_DIR
  cd $TMP_DIR
  test -d dotgit && mv dotgit .git
}

# Load in bash_prompt
. .bash_prompt

# is_on_git

  # in a git directory
  fixture_dir 'git'

    # has an exit code of 0
    is_on_git || echo '`is_on_git` === "" in git directory' 1>&2

  # in a non-git directory
  fixture_dir 'non-git'

    # has a non-zero exit code
    ! is_on_git || echo '`is_on_git` !== "" in non-git directory' 1>&2

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
