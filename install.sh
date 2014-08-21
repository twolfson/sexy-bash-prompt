#!/usr/bin/env bash

# Create helper to determine if our PS1 is installed
ps1_is_installed () {
  # If our prompt is being loaded, exit positively. Otherwise, negatively.
  # DEV: Regression for ps1 check via #24
  [[ -n "$(bash --login -i -c 'echo $PS1' | grep 'get_git_info')" ]]
}

# If the PS1 already contains our current prompt, leave
ps1_is_installed && exit 0

# Add the .bash_prompt invocation to .bashrc
echo "# Adding ~/.bash_prompt to ~/.bashrc"
echo "# Run twolfson/sexy-bash-prompt" >> ~/.bashrc
echo ". ~/.bash_prompt" >> ~/.bashrc

# If our prompt is being loaded, leave
ps1_is_installed && exit 0

# By default, .bash_profile is our profile script
profile_script_short="~/.bash_profile"
profile_script_full=~/.bash_profile

# Find which exists .bash_profile, .bash_login, or .profile
if [[ -f ~/.bash_profile ]]; then
  : # Use defaults
elif [[ -f ~/.bash_login ]]; then
  profile_script_short="~/.bash_login"
  profile_script_full=~/.bash_login
elif [[ -f ~/.profile ]]; then
  profile_script_short="~/.profile"
  profile_script_full=~/.profile
fi

# If the current script does not have notes about .bashrc
# DEV: Introduced due to #24, a regression that prevented users from logging in
if ! grep .bashrc "$profile_script_full" &> /dev/null; then
  # Add a bash invocation to the profile script
  echo "# Adding ~/.bashrc triggers to $profile_script_short"
  echo "# Trigger ~/.bashrc commands" >> "$profile_script_full"
  echo ". ~/.bashrc" >> "$profile_script_full"

  # If our prompt is not being loaded, notify the user and leave angrily
  ps1_is_installed || (echo "sexy-bash-prompt was added to ~/.bashrc \
and $profile_script_short but is not being picked up by bash." 1>&2 && exit 1)
# Otherwise, notify the user about how to add it but do nothing
else
  echo "# We cannot confirm that sexy-bash-prompt has installed properly" 1>&2
  echo "# Please open a new terminal window to confirm" 1>&2
  echo "" 1>&2
  echo "# If it has not, please run the following code:" 1>&2
  echo "echo \". ~/.bashrc\" >> \"$profile_script_full\"" 1>&2
  exit 1
fi
