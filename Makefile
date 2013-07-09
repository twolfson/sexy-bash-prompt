install:
	@echo "# Copying .bashrc to ~/.bash_prompt"
	cp --force .bashrc ~/.bash_prompt

	@echo "# Adding ~/.bash_prompt to ~/.bashrc"
	@echo "# Run twolfson/sexy-bash-prompt" >> ~/.bashrc
	echo ". ~/.bash_prompt" >> ~/.bashrc

	@echo "# twolfson/sexy-bash-prompt installation complete!"

install-link:
	@echo "# Copying .bashrc to ~/.bash_prompt"
	ln --force --symbolic $(PWD)/.bashrc $(HOME)/.bash_prompt

	@echo "# Adding ~/.bash_prompt to ~/.bashrc"
	@echo "# Run twolfson/sexy-bash-prompt" >> ~/.bashrc
	echo ". ~/.bash_prompt" >> ~/.bashrc

	@echo "# twolfson/sexy-bash-prompt installation complete!"

clean:
	rm test.stderr

test:
	# Clean up past stderr
	@make clean

	# Run prompt test and output to stderr
	bash --norc --noprofile -i -c "./test/prompt_test.sh" 2>> test.stderr

	# If there were test failures, fail
	$(abc =)
	echo  $(cat test.stderr)
	# if test -n $(ABC); then
	#   echo "ERRORS OCCURRED. ABC OUTPUT:" 1>&2
	#   echo $ABC 1>&2
	#   exit 1
	# else
	#   echo "All tests passed!"
	#   exit 0
	# fi

.PHONY: install install-link clean test