add-to-bashrc:
	@echo "# Run twolfson/sexy-bash-prompt" >> ~/.bashrc
	@echo ". ~/.bash_prompt" >> ~/.bashrc

install:
	@echo "# Copying .bashrc to ~/.bash_prompt"
	@ # Install sexy bash prompt to dotfiles
	cp -f .bashrc ~/.bash_prompt

	@echo "# Adding ~/.bash_prompt to ~/.bashrc"
	@ # Append it to the .bashrc execution
	@$(make add-to-bashrc)

	@echo "# twolfson/sexy-bash-prompt installation complete!"

.PHONY: docs clean docclean install uninstall