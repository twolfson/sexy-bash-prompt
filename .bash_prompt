#!/usr/bin/env bash
# Sexy bash prompt by twolfson
# https://github.com/twolfson/sexy-bash-prompt
# Forked from gf3, https://gist.github.com/gf3/306785

# If we are on a colored terminal
if tput setaf 1 &> /dev/null; then
  # Reset the shell from our `if` check
  tput sgr0 &> /dev/null

  # If you would like to customize your colors, use
  # # Attribution: http://linuxtidbits.wordpress.com/2008/08/11/output-color-on-bash-scripts/
  # for i in $(seq 0 $(tput colors)); do
  #   echo " $(tput setaf $i)Text$(tput sgr0) $(tput bold)$(tput setaf $i)Text$(tput sgr0) $(tput sgr 0 1)$(tput setaf $i)Text$(tput sgr0)  \$(tput setaf $i)"
  # done

  # Save common color actions
  sexy_bash_prompt_bold="$(tput bold)"
  sexy_bash_prompt_reset="$(tput sgr0)"

  # If the terminal supports at least 256 colors, write out our 256 color based set
  if [[ "$(tput colors)" -ge 256 ]] &> /dev/null; then
    sexy_bash_prompt_user_color="$sexy_bash_prompt_bold$(tput setaf 27)" # BOLD BLUE
    sexy_bash_prompt_preposition_color="$sexy_bash_prompt_bold$(tput setaf 7)" # BOLD WHITE
    sexy_bash_prompt_device_color="$sexy_bash_prompt_bold$(tput setaf 39)" # BOLD CYAN
    sexy_bash_prompt_dir_color="$sexy_bash_prompt_bold$(tput setaf 76)" # BOLD GREEN
    sexy_bash_prompt_git_status_color="$sexy_bash_prompt_bold$(tput setaf 154)" # BOLD YELLOW
    sexy_bash_prompt_git_progress_color="$sexy_bash_prompt_bold$(tput setaf 9)" # BOLD RED
  else
  # Otherwise, use colors from our set of 8
    sexy_bash_prompt_user_color="$sexy_bash_prompt_bold$(tput setaf 4)" # BOLD BLUE
    sexy_bash_prompt_preposition_color="$sexy_bash_prompt_bold$(tput setaf 7)" # BOLD WHITE
    sexy_bash_prompt_device_color="$sexy_bash_prompt_bold$(tput setaf 6)" # BOLD CYAN
    sexy_bash_prompt_dir_color="$sexy_bash_prompt_bold$(tput setaf 2)" # BOLD GREEN
    sexy_bash_prompt_git_status_color="$sexy_bash_prompt_bold$(tput setaf 3)" # BOLD YELLOW
    sexy_bash_prompt_git_progress_color="$sexy_bash_prompt_bold$(tput setaf 1)" # BOLD RED
  fi

  sexy_bash_prompt_symbol_color="$sexy_bash_prompt_bold" # BOLD
  sexy_bash_prompt_symbol_error_color="$sexy_bash_prompt_bold$(tput setaf 1)" # BOLD RED
else
# Otherwise, use ANSI escape sequences for coloring
  # If you would like to customize your colors, use
  # DEV: 30-39 lines up 0-9 from `tput`
  # for i in $(seq 0 109); do
  #   echo -n -e "\033[1;${i}mText$(tput sgr0) "
  #   echo "\033[1;${i}m"
  # done

  sexy_bash_prompt_reset="\033[m"
  sexy_bash_prompt_user_color="\033[1;34m" # BLUE
  sexy_bash_prompt_preposition_color="\033[1;37m" # WHITE
  sexy_bash_prompt_device_color="\033[1;36m" # CYAN
  sexy_bash_prompt_dir_color="\033[1;32m" # GREEN
  sexy_bash_prompt_git_status_color="\033[1;33m" # YELLOW
  sexy_bash_prompt_git_progress_color="\033[1;31m" # RED
  sexy_bash_prompt_symbol_color="" # NORMAL
  sexy_bash_prompt_symbol_error_color="\033[1;31m" # RED
fi

# Define the default prompt terminator character '$'
if [[ "$UID" == 0 ]]; then
  sexy_bash_prompt_symbol="#"
else
  sexy_bash_prompt_symbol="\$"
fi

# Apply any color overrides that have been set in the environment
if [[ -n "$PROMPT_USER_COLOR" ]]; then sexy_bash_prompt_user_color="$PROMPT_USER_COLOR"; fi
if [[ -n "$PROMPT_PREPOSITION_COLOR" ]]; then sexy_bash_prompt_preposition_color="$PROMPT_PREPOSITION_COLOR"; fi
if [[ -n "$PROMPT_DEVICE_COLOR" ]]; then sexy_bash_prompt_device_color="$PROMPT_DEVICE_COLOR"; fi
if [[ -n "$PROMPT_DIR_COLOR" ]]; then sexy_bash_prompt_dir_color="$PROMPT_DIR_COLOR"; fi
if [[ -n "$PROMPT_GIT_STATUS_COLOR" ]]; then sexy_bash_prompt_git_status_color="$PROMPT_GIT_STATUS_COLOR"; fi
if [[ -n "$PROMPT_GIT_PROGRESS_COLOR" ]]; then sexy_bash_prompt_git_progress_color="$PROMPT_GIT_PROGRESS_COLOR"; fi
if [[ -n "$PROMPT_SYMBOL" ]]; then sexy_bash_prompt_symbol="$PROMPT_SYMBOL"; fi
if [[ -n "$PROMPT_SYMBOL_COLOR" ]]; then sexy_bash_prompt_symbol_color="$PROMPT_SYMBOL_COLOR"; fi
if [[ -n "$PROMPT_SYMBOL_ERROR_COLOR" ]]; then sexy_bash_prompt_symbol_error_color="$PROMPT_SYMBOL_ERROR_COLOR"; fi

# Set up symbols
sexy_bash_prompt_synced_symbol=""
sexy_bash_prompt_dirty_synced_symbol="*"
sexy_bash_prompt_unpushed_symbol="△"
sexy_bash_prompt_dirty_unpushed_symbol="▲"
sexy_bash_prompt_unpulled_symbol="▽"
sexy_bash_prompt_dirty_unpulled_symbol="▼"
sexy_bash_prompt_unpushed_unpulled_symbol="⬡"
sexy_bash_prompt_dirty_unpushed_unpulled_symbol="⬢"

# Apply symbol overrides that have been set in the environment
# DEV: Working unicode symbols can be determined via the following gist
#   **WARNING: The following gist has 64k lines and may freeze your browser**
#   https://gist.github.com/twolfson/9cc7968eb6ee8b9ad877
if [[ -n "$PROMPT_SYNCED_SYMBOL" ]]; then sexy_bash_prompt_synced_symbol="$PROMPT_SYNCED_SYMBOL"; fi
if [[ -n "$PROMPT_DIRTY_SYNCED_SYMBOL" ]]; then sexy_bash_prompt_dirty_synced_symbol="$PROMPT_DIRTY_SYNCED_SYMBOL"; fi
if [[ -n "$PROMPT_UNPUSHED_SYMBOL" ]]; then sexy_bash_prompt_unpushed_symbol="$PROMPT_UNPUSHED_SYMBOL"; fi
if [[ -n "$PROMPT_DIRTY_UNPUSHED_SYMBOL" ]]; then sexy_bash_prompt_dirty_unpushed_symbol="$PROMPT_DIRTY_UNPUSHED_SYMBOL"; fi
if [[ -n "$PROMPT_UNPULLED_SYMBOL" ]]; then sexy_bash_prompt_unpulled_symbol="$PROMPT_UNPULLED_SYMBOL"; fi
if [[ -n "$PROMPT_DIRTY_UNPULLED_SYMBOL" ]]; then sexy_bash_prompt_dirty_unpulled_symbol="$PROMPT_DIRTY_UNPULLED_SYMBOL"; fi
if [[ -n "$PROMPT_UNPUSHED_UNPULLED_SYMBOL" ]]; then sexy_bash_prompt_unpushed_unpulled_symbol="$PROMPT_UNPUSHED_UNPULLED_SYMBOL"; fi
if [[ -n "$PROMPT_DIRTY_UNPUSHED_UNPULLED_SYMBOL" ]]; then sexy_bash_prompt_dirty_unpushed_unpulled_symbol="$PROMPT_DIRTY_UNPUSHED_UNPULLED_SYMBOL"; fi

# Set up behavior options
sexy_bash_prompt_show_error_once="1"

# Apply behavior overrides that have been set in the environment
if [[ -n "$PROMPT_SHOW_ERROR_ONCE" ]]; then sexy_bash_prompt_show_error_once="$PROMPT_SHOW_ERROR_ONCE"; fi

# Define all our helper functions
function sexy_bash_prompt_get_git_branch() {
  # On branches, this will return the branch name
  # On non-branches, (no branch)
  ref="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
  if [[ "$ref" != "" ]]; then
    echo "$ref"
  else
    echo "(no branch)"
  fi
}

function sexy_bash_prompt_get_git_progress() {
  # Detect in-progress actions (e.g. merge, rebase)
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1199-L1241
  git_dir="$(git rev-parse --git-dir)"

  # git merge
  if [[ -f "$git_dir/MERGE_HEAD" ]]; then
    echo " [merge]"
  elif [[ -d "$git_dir/rebase-apply" ]]; then
    # git am
    if [[ -f "$git_dir/rebase-apply/applying" ]]; then
      echo " [am]"
    # git rebase
    else
      echo " [rebase]"
    fi
  elif [[ -d "$git_dir/rebase-merge" ]]; then
    # git rebase --interactive/--merge
    echo " [rebase]"
  elif [[ -f "$git_dir/CHERRY_PICK_HEAD" ]]; then
    # git cherry-pick
    echo " [cherry-pick]"
  fi
  if [[ -f "$git_dir/BISECT_LOG" ]]; then
    # git bisect
    echo " [bisect]"
  fi
  if [[ -f "$git_dir/REVERT_HEAD" ]]; then
    # git revert --no-commit
    echo " [revert]"
  fi
}

sexy_bash_prompt_is_branch1_behind_branch2 () {
  # $ git log origin/master..master -1
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # Find the first log (if any) that is in branch1 but not branch2
  first_log="$(git log $1..$2 -1 2> /dev/null)"

  # Exit with 0 if there is a first log, 1 if there is not
  [[ -n "$first_log" ]]
}

sexy_bash_prompt_branch_exists () {
  # List remote branches           | # Find our branch and exit with 0 or 1 if found/not found
  git branch --remote 2> /dev/null | grep --quiet "$1"
}

sexy_bash_prompt_parse_git_ahead () {
  # Grab the local and remote branch
  branch="$(sexy_bash_prompt_get_git_branch)"
  remote="$(git config --get "branch.${branch}.remote" || echo -n "origin")"
  remote_branch="$remote/$branch"

  # $ git log origin/master..master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # If the remote branch is behind the local branch
  # or it has not been merged into origin (remote branch doesn't exist)
  if (sexy_bash_prompt_is_branch1_behind_branch2 "$remote_branch" "$branch" ||
      ! sexy_bash_prompt_branch_exists "$remote_branch"); then
    # echo our character
    echo 1
  fi
}

sexy_bash_prompt_parse_git_behind () {
  # Grab the branch
  branch="$(sexy_bash_prompt_get_git_branch)"
  remote="$(git config --get "branch.${branch}.remote" || echo -n "origin")"
  remote_branch="$remote/$branch"

  # $ git log master..origin/master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # If the local branch is behind the remote branch
  if sexy_bash_prompt_is_branch1_behind_branch2 "$branch" "$remote_branch"; then
    # echo our character
    echo 1
  fi
}

function sexy_bash_prompt_parse_git_dirty() {
  # If the git status has *any* changes (e.g. dirty), echo our character
  if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then
    echo 1
  fi
}

function sexy_bash_prompt_is_on_git() {
  git rev-parse 2> /dev/null
}

function sexy_bash_prompt_get_git_status() {
  # Grab the git dirty and git behind
  dirty_branch="$(sexy_bash_prompt_parse_git_dirty)"
  branch_ahead="$(sexy_bash_prompt_parse_git_ahead)"
  branch_behind="$(sexy_bash_prompt_parse_git_behind)"

  # Iterate through all the cases and if it matches, then echo
  if [[ "$dirty_branch" == 1 && "$branch_ahead" == 1 && "$branch_behind" == 1 ]]; then
    echo "$sexy_bash_prompt_dirty_unpushed_unpulled_symbol"
  elif [[ "$branch_ahead" == 1 && "$branch_behind" == 1 ]]; then
    echo "$sexy_bash_prompt_unpushed_unpulled_symbol"
  elif [[ "$dirty_branch" == 1 && "$branch_ahead" == 1 ]]; then
    echo "$sexy_bash_prompt_dirty_unpushed_symbol"
  elif [[ "$branch_ahead" == 1 ]]; then
    echo "$sexy_bash_prompt_unpushed_symbol"
  elif [[ "$dirty_branch" == 1 && "$branch_behind" == 1 ]]; then
    echo "$sexy_bash_prompt_dirty_unpulled_symbol"
  elif [[ "$branch_behind" == 1 ]]; then
    echo "$sexy_bash_prompt_unpulled_symbol"
  elif [[ "$dirty_branch" == 1 ]]; then
    echo "$sexy_bash_prompt_dirty_synced_symbol"
  else # clean
    echo "$sexy_bash_prompt_synced_symbol"
  fi
}

sexy_bash_prompt_get_git_info () {
  # Grab the branch
  branch="$(sexy_bash_prompt_get_git_branch)"

  # If there are any branches
  if [[ "$branch" != "" ]]; then
    # Echo the branch
    output="$branch"

    # Add on the git status
    output="$output$(sexy_bash_prompt_get_git_status)"

    # Echo our output
    echo "$output"
  fi
}

sexy_bash_prompt_get_symbol_color () {
  # Verify we have an exit code set
  if [[ "$sexy_bash_prompt_exit_code" == "" ]]; then
    echo "Missing \`sexy_bash_prompt_exit_code\` for prompt symbol coloring" 1>&2
    echo "Please verify \`PROMPT_COMMAND\` includes \`sexy_bash_prompt_command\` (enabled unless overwritten)" 1>&2
    echo "$sexy_bash_prompt_symbol_color"
    return
  fi
  exit_code="$sexy_bash_prompt_exit_code"

  # If we'd like to show errors once, then inspect further
  # DEV: This is a personal preference around seeing a red $ on any failing command consistently
  # DEV: This also works to ignore keyboard interrupts in the prompt itself (normally exit code 130)
  #   This will respect keyboard interrupt in running programs though (e.g. `time cat`)
  # DEV: Further explanation of all scenarios, https://github.com/twolfson/sexy-bash-prompt/pull/89#issuecomment-685239313
  if [[ "$sexy_bash_prompt_show_error_once" == "1" ]]; then
    # If the last command has not changed (including its timestamp), then ignore our exit code
    # last_command="501  echo hi"
    if [[ "$sexy_bash_prompt_last_command" == "$sexy_bash_prompt_current_command" ]]; then
      exit_code="0"
    fi
  fi

  # Determine and output our symbol color
  symbol_color="$sexy_bash_prompt_symbol_color"
  if [[ "$exit_code" != 0 ]]; then
    symbol_color="$sexy_bash_prompt_symbol_error_color"
  fi
  echo "$symbol_color"
}

# Define our hooks for storing the exit code and past commands
sexy_bash_prompt_current_command=""
sexy_bash_prompt_command () {
  # Capture and expose exit code first before anything, otherwise it'll be lost
  export sexy_bash_prompt_exit_code="$?"

  # Capture last commands for `SEXY_BASH_PROMPT_SHOW_ERROR_ONCE` logic
  # DEV: We would save these in `get_symbol_color` but its subshell variables don't persist
  export sexy_bash_prompt_last_command="$sexy_bash_prompt_current_command"
  export sexy_bash_prompt_current_command="$(history 1)"

  # DEV: We don't set PS1 in here as it would prevent extension, see https://github.com/twolfson/sexy-bash-prompt/issues/90
}
# DEV: Extend `PROMPT_COMMAND` if there already is one
if [[ "$PROMPT_COMMAND" != "" ]]; then
  PROMPT_COMMAND="sexy_bash_prompt_command ; $PROMPT_COMMAND"
else
  PROMPT_COMMAND="sexy_bash_prompt_command"
fi

# Define the sexy-bash-prompt
PS1="\[$sexy_bash_prompt_reset\]\
\[$sexy_bash_prompt_user_color\]\u\[$sexy_bash_prompt_reset\] \
\[$sexy_bash_prompt_preposition_color\]at\[$sexy_bash_prompt_reset\] \
\[$sexy_bash_prompt_device_color\]\h\[$sexy_bash_prompt_reset\] \
\[$sexy_bash_prompt_preposition_color\]in\[$sexy_bash_prompt_reset\] \
\[$sexy_bash_prompt_dir_color\]\w\[$sexy_bash_prompt_reset\]\
\$( sexy_bash_prompt_is_on_git && \
  echo -n \" \[$sexy_bash_prompt_preposition_color\]on\[$sexy_bash_prompt_reset\] \" && \
  echo -n \"\[$sexy_bash_prompt_git_status_color\]\$(sexy_bash_prompt_get_git_info)\" && \
  echo -n \"\[$sexy_bash_prompt_git_progress_color\]\$(sexy_bash_prompt_get_git_progress)\" && \
  echo -n \"\[$sexy_bash_prompt_reset\]\")\n\
\[\$(sexy_bash_prompt_get_symbol_color)\]$sexy_bash_prompt_symbol \[$sexy_bash_prompt_reset\]"
