# Install sexy bash prompt to dotfiles
cp .bashrc ~/.bash_prompt

# Append it to the .bashrc execution
echo "# Run sexy-bash-prompt" >> ~/.bashrc
echo ". ~/.bash_prompt" >> ~/.bashrc
