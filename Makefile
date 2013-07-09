DOTGIT_DIRS := $(wildcard test/test-files/*/dotgit)
GIT_DIRS := $(wildcard test/test-files/*/.git)

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
	# Running all tests
	./test/run.sh

move-to-dotgit:
	# Iterate over the dotgit directories
	$(foreach ORIG_DIR, $(DOTGIT_DIRS), \
	  mv $(ORIG_DIR) $(ORIG_DIR)/../.git; \
	)

move-to-git:
	# Iterate over the .git directories
	$(foreach ORIG_DIR, $(GIT_DIRS), \
	  mv $(ORIG_DIR) $(ORIG_DIR)/../dotgit; \
	)


.PHONY: install install-link clean test