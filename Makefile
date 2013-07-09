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
	@echo "# Cleaning up test files"
	-rm test.stderr

test: clean
	# Run prompt test and output to stderr
	@echo "# Running prompt test"
	bash --norc --noprofile -i -c "./test/prompt_test.sh" 2>> test.stderr

	# If there were test failures, fail
	if test -s test.stderr; then
	  echo "# ERRORS OCCURRED. STDERR OUTPUT:" 1>&2
	  cat test.stderr 1>&2
	  exit 1
	else
	  echo "# All tests passed!"
	  exit 0
	fi

.PHONY: install install-link clean test