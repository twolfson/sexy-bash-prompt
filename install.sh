#!/usr/bin/env bash

# Create helper to determine if our PS1 is installed
ps1_is_installed () {
  # If our prompt is being loaded, exit positively
  if [[ -n "$(bash -i -c 'echo $PS1' | grep 'get_git_info')" ]]; then
    exit 0
  fi

  # Otherwise, exit negatively
  exit 1
}

# # If the PS1 already contains our current prompt, leave
# ps1_is_installed && exit 0

# # Add the .bash_prompt invocation to .bashrc
# echo "# Adding ~/.bash_prompt to ~/.bashrc"
# echo "# Run twolfson/sexy-bash-prompt" >> ~/.bashrc
# echo ". ~/.bash_prompt" >> ~/.bashrc

# # Trigger the prompt
# . ~/.bashrc

# # If our prompt is being loaded, leave
# ps1_is_installed && exit 0

# By default, .bash_profile is our profile script
PROFILE_SCRIPT=~/.bash_profile

# Find which exists .bash_profile, .bash_login, or .profile
if [[ -f ~/.bash_profile ]]; then
  PROFILE_SCRIPT=~/.bash_profile
elif [[ -f ~/.bash_login ]]; then
  PROFILE_SCRIPT=~/.bash_login
elif [[ -f ~/.profile ]]; then
  PROFILE_SCRIPT=~/.profile
fi

# # Add a bash invocation to the profile script
# echo "# Adding ~/.bashrc triggers to $PROFILE_SCRIPT"
# echo "# Trigger ~/.bashrc commands" >> ~/.bashrc
# echo ". ~/.bashrc" >> "$PROFILE_SCRIPT"

# If our prompt is not being loaded, notify the user and leave angrily
ps1_is_installed || (echo "sexy-bash-prompt was added to .bashrc and $PROFILE_SCRIPT but was not detected as installed properly." 1>&2 && exit 1)
