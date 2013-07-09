DOTGIT_DIRS := $(wildcard test/test-files/*/dotgit)
GIT_DIRS := $(wildcard test/test-files/*/.git)

install:
	@echo "# Copying .bashrc to ~/.bash_prompt"
	cp -f .bashrc ~/.bash_prompt

	@echo "# Adding ~/.bash_prompt to ~/.bashrc"
	@echo "# Run twolfson/sexy-bash-prompt" >> ~/.bashrc
	echo ". ~/.bash_prompt" >> ~/.bashrc

	@echo "# twolfson/sexy-bash-prompt installation complete!"
	exit 0

install-link:
	@echo "# Copying .bashrc to ~/.bash_prompt"
	ln -f -s $(PWD)/.bashrc $(HOME)/.bash_prompt

	@echo "# Adding ~/.bash_prompt to ~/.bashrc"
	@echo "# Run twolfson/sexy-bash-prompt" >> ~/.bashrc
	echo ". ~/.bash_prompt" >> ~/.bashrc

	@echo "# twolfson/sexy-bash-prompt installation complete!"
	exit 0

clean:
	@echo "# Cleaning up test files"
	-rm test.stderr

test: clean
	# Running all tests
	./test/run.sh

move-dotgit-to-git:
	# Moving over the dotgit directories to git directories
	@$(foreach ORIG_DIR, $(DOTGIT_DIRS), \
		echo "Moving $(ORIG_DIR) to $(ORIG_DIR)/../.git"; \
		mv $(ORIG_DIR) $(ORIG_DIR)/../.git; \
	)

move-git-to-dotgit:
	# Moving over the git directories to dotgit directories
	@$(foreach ORIG_DIR, $(GIT_DIRS), \
		echo "Moving $(ORIG_DIR) to $(ORIG_DIR)/../dotgit"; \
		mv $(ORIG_DIR) $(ORIG_DIR)/../dotgit; \
	)


.PHONY: install install-link clean test
