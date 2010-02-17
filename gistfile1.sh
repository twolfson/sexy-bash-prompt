# Sexy Bash Prompt, inspired by "Extravagant Zsh Prompt"
# Screenshot: http://i.imgur.com/uAQSa.png
# A big thanks to \amethyst on Freenode

if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then TERM=gnome-256color; fi
MAGENTA=$(tput setaf 9)
ORANGE=$(tput setaf 172)
GREEN=$(tput setaf 190)
PURPLE=$(tput setaf 141)
WHITE=$(tput setaf 256)
BOLD=$(tput bold)
RESET=$(tput sgr0)

parse_git_dirty () {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]at \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(__git_ps1) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n\$ \[$RESET\]"