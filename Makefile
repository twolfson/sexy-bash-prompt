DOTGIT_DIRS = $(wildcard test/test-files/*/dotgit)
GIT_DIRS = $(wildcard test/test-files/*/.git)

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
	$(for DOTGIT_DIR in $(DOTGIT_DIRS); do
	  # Find the target directory
	  TARGET_DOTGIT_DIR="$(dirname $DOTGIT_DIR)"/.git

	  # Move over the directories
	  echo "Moving $DOTGIT_DIR to $TARGET_DOTGIT_DIR"
	  mv $DOTGIT_DIR $TARGET_DOTGIT_DIR
	done)


.PHONY: install install-link clean test