# Sexy bash prompt by twolfson
# https://github.com/twolfson/sexy-bash-prompt
# Forked from gf3, https://gist.github.com/gf3/306785

# Determine what type of terminal we are using for `tput`
if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then export TERM=gnome-256color
elif [[ $TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
fi

# If we are on a colored terminal
if tput setaf 1 &> /dev/null; then
    # Reset the shell from our `if` check
    tput sgr0

    # If the terminal supports at least 256 colors, write out our 256 colors
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      USER=$(tput setaf 27) #BLUE
      PREPOSITION=$(tput setaf 7) #WHITE
      DEVICE=$(tput setaf 39) #INDIGO
      DIR=$(tput setaf 76) #GREEN
      GIT_STATUS=$(tput setaf 154) #YELLOW
    else
    # Otherwise, use colors from our set of 16
      # Original colors from fork
      USER=$(tput setaf 5) #MAGENTA
      PREPOSITION=$(tput setaf 7) #WHITE
      DEVICE=$(tput setaf 4) #ORANGE
      DIR=$(tput setaf 2) #GREEN
      GIT_STATUS=$(tput setaf 1) #PURPLE
    fi

    # Save common color actions
    BOLD=$(tput bold)
    NORMAL=$PREPOSITION
    RESET=$(tput sgr0)
else
# Otherwise, use ANSI escape sequences for coloring
    # Original colors from fork
    USER="\033[1;31m" #MAGENTA
    PREPOSITION="\033[1;37m" #WHITE
    DEVICE="\033[1;33m" #ORANGE
    DIR="\033[1;32m" #GREEN
    GIT_STATUS="\033[1;35m" #PURPLE
    BOLD=""
    RESET="\033[m"
fi

function get_git_branch() {
  # Grab the branch                  | ltrim unused rows    Remove asterisk
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}

get_origin_ahead_diff () {
  # Grab the branches
  BRANCH=$(get_git_branch)
  REMOTE_BRANCH=origin/$BRANCH

  # Look up the result
  git log $REMOTE_BRANCH..$BRANCH -1 --no-color 2> /dev/null | head -n1
}

parse_git_ahead () {
  # Grab the branch
  BRANCH=$(get_git_branch)

  # Linux Mint 14
  # todd at Euclid in ~/github/dotfiles/test/test-files/unpushed on master△
  # $ git log origin/master..master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # If the diff         begins with "commit"
  [[ $(get_origin_ahead_diff | sed -e "s/^\(commit\).*/\1/") == "commit" ]] ||
    # or it has not been merged into origin
    [[ $(git branch -r --no-color 2> /dev/null | grep origin/$BRANCH 2> /dev/null | tail -n1) == "" ]] &&
    # echo our character
    echo 1
}

get_origin_behind_diff () {
  # Grab the branches
  BRANCH=$(get_git_branch)
  REMOTE_BRANCH=origin/$BRANCH

  # Look up the result
  git log $BRANCH..$REMOTE_BRANCH -1 --no-color 2> /dev/null | head -n1
}

parse_git_behind () {
  # Linux Mint 14
  # todd at Euclid in ~/github/dotfiles/test/test-files/unpulled on master
  # $ git log master..origin/master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # If the diff         begins with "commit"
  [[ $(get_origin_behind_diff | sed -e "s/^\(commit\).*/\1/") == "commit" ]] &&
    # echo our character
    echo 1
}

parse_git_dirty () {
  # nothing to commit, working directory clean
  # nothing to commit (working directory clean)
  [[ $(git status 2> /dev/null | tail -n1 | sed -E "s/nothing to commit..working directory clean.?/1/") != "1" ]] && echo 1
}

function get_git_status() {
  # Grab the git dirty and git behind
  DIRTY_BRANCH=$(parse_git_dirty)
  BRANCH_AHEAD=$(parse_git_ahead)
  BRANCH_BEHIND=$(parse_git_behind)

  if [[ $DIRTY_BRANCH == 1 && $BRANCH_AHEAD == 1 && $BRANCH_BEHIND == 1 ]]; then
    echo "⬢"
  elif [[ $DIRTY_BRANCH == 1 && $BRANCH_AHEAD == 1 ]]; then
    echo "▲"
  elif [[ $DIRTY_BRANCH == 1 && $BRANCH_BEHIND == 1 ]]; then
    echo "▼"
  elif [[ $BRANCH_AHEAD == 1 && $BRANCH_BEHIND == 1 ]]; then
    echo "⬡"
  elif [[ $BRANCH_AHEAD == 1 ]]; then
    echo "△"
  elif [[ $BRANCH_BEHIND == 1 ]]; then
    echo "▽"
  elif [[ $DIRTY_BRANCH == 1 ]]; then
    echo "*"
  fi
}

get_git_info () {
  # Grab the branch
  BRANCH=$(get_git_branch)

  # If there are any branches
  if [[ $BRANCH != "" ]]; then
    # Echo the branch
    OUTPUT=$BRANCH

    # Add on the git status
    OUTPUT=$OUTPUT"$(get_git_status)"

    # Echo our output
    echo $OUTPUT
  fi
}

# ⍺ - alpha &#9082;
# λ - lambda &lambda; &#955;
# ∴ - therefore &there4; &#8756;
# ± - plus-minus &plusmn; &#177;
# ∓ - plus-minus-alt &plusmn; &#8723;
# Δ - &Delta; &#916;
# ∇ - &nabla; &#8711;
# ▵ - Smaller delta &#9653;
# ▴ - Smaller filled &#9652;
# ▲ - Slightly bigger delta &#9651;
# △ - Slightly bigger filled &#9650;
# More characters experimented in https://github.com/twolfson/dotfiles/issues/4

function is_on_git() {
  git branch 2> /dev/null
}

get_prompt_symbol () {
  # git branch --no-color 1> /dev/null 2> /dev/null && echo "∓" && return
  echo "$"
}

# When on clean git branch,              $USER at $COMPUTER in $PWD on $branch
# When on dirty git branch,              $USER at $COMPUTER in $PWD on $branch*
# When on unsynced git branch,           $USER at $COMPUTER in $PWD on $branch▵
# When on unsynced and dirty git branch, $USER at $COMPUTER in $PWD on $branch▴

PS1="\[${BOLD}${USER}\]\u \[$PREPOSITION\]at \[$DEVICE\]\h \[$PREPOSITION\]in \[$DIR\]\w\[$PREPOSITION\]\$([[ -n \$(is_on_git) ]] && echo \" on \")\[$GIT_STATUS\]\$(get_git_info)\[$NORMAL\]\n$(get_prompt_symbol) \[$RESET\]"
