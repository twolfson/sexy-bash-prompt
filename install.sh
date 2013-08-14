# Get the current PS1
get_ps1 () {
  bash -i -c 'echo $PS1'
}

# If already contains our current prompt, leave
if [[ -n "$(get_ps1 | grep get_git_info)" ]]; then
  exit 0
fi

# Add the .bash_prompt invocation to .bashrc
echo "# Adding ~/.bash_prompt to ~/.bashrc"
echo "echo \". ~/.bash_prompt\" >> ~/.bashrc"
echo ". ~/.bash_prompt" >> ~/.bashrc

# If our prompt is being loaded, leave
if [[ -n "$(get_ps1 | grep get_git_info)" ]]; then
  exit 0
fi

# Find which exists .bash_profile, .bash_login, or .profile

# If there is no profile_script, fallback to .bash_profile

# Add a bash invocation to .bashrc

# Get the current PS1

# If our prompt is not being loaded, notify the user and leave angrily
