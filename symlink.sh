# Install sexy bash prompt to dotfiles
ln -s $PWD/.bashrc $HOME/.bash_prompt

# Append it to the .bashrc execution
echo "# Run twolfson/sexy-bash-prompt" >> ~/.bashrc
echo ". ~/.bash_prompt" >> ~/.bashrc
