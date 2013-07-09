install:
	@echo "# Copying .bashrc to ~/.bash_prompt"
	cp -f .bashrc ~/.bash_prompt

	@echo "# Adding ~/.bash_prompt to ~/.bashrc"
	@echo "# Run twolfson/sexy-bash-prompt" >> ~/.bashrc
	echo ". ~/.bash_prompt" >> ~/.bashrc

	@echo "# twolfson/sexy-bash-prompt installation complete!"

.PHONY: docs clean docclean install uninstall