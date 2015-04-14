TEST_DIRS := $(notdir $(wildcard test/test-files/*))
DOTGIT_DIRS := $(wildcard test/test-files/*/dotgit)
GIT_DIRS := $(wildcard test/test-files/*/.git)

install:
	@echo "# Copying .bash_prompt to ~/.bash_prompt"
	cp -f ".bash_prompt" "$(HOME)/.bash_prompt"

	@# Run install script
	./install.bash

	@echo "# twolfson/sexy-bash-prompt installation complete!"
	exit 0

install-link:
	@echo "# Linking .bash_prompt to ~/.bash_prompt"
	ln -f -s "$(PWD)/.bash_prompt" "$(HOME)/.bash_prompt"

	@# Run install script
	./install.bash

	@echo "# twolfson/sexy-bash-prompt installation complete!"
	exit 0

clean:
	@echo "# Cleaning up test files"
	-rm test.stderr

test: clean
	# Running prompt test
	./test/run.sh

test-install:
	# Running install test
	./test/install_test.sh

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

demo:
	# Move dotgit to git for copying
	make move-dotgit-to-git

	# Make non-git directory for demo
	mkdir -p ~/non-git

	# Copy over all the directories to /tmp/
	rm -rf /tmp/git/
	mkdir -p /tmp/git/
	$(foreach TEST_DIR, $(TEST_DIRS), \
		cp -r test/test-files/$(TEST_DIR) /tmp/git/$(TEST_DIR); \
	)

	# Move back git to dotgit dirs
	make move-git-to-dotgit

	# Output follow up commands
	@echo "Demo environment set up. Please run the following commands:"
	@echo '"""'
	@echo "cd ~/non-git"
	@echo "cd /tmp/git/synced"
	@echo "cd /tmp/git/dirty-synced"
	@echo "cd /tmp/git/unpushed"
	@echo "cd /tmp/git/dirty-unpushed"
	@echo "cd /tmp/git/unpulled"
	@echo "cd /tmp/git/dirty-unpulled"
	@echo "cd /tmp/git/unpushed-unpulled"
	@echo "cd /tmp/git/dirty-unpushed-unpulled"
	@echo '"""'
	@echo ''
	@echo "Showcase in progress keywords:"
	@echo '"""'
	@echo "cd /tmp/git/merge-in-progress"
	@echo "cd /tmp/git/rebase-in-progress"
	@echo "cd /tmp/git/bisect-in-progress"
	@echo "cd /tmp/git/cherry-pick-in-progress"
	@echo '"""'

color-check:
	@echo 'bash --norc'
	@echo 'TERM=xterm-256color . .bash_prompt'
	@echo 'TERM=xterm . .bash_prompt'
	@echo 'TERM="" . .bash_prompt'
	@echo 'TERM=xterm-256color PROMPT_USER_COLOR="\033[1;32m" PROMPT_PREPOSITION_COLOR="\033[1;33m" PROMPT_DEVICE_COLOR="\033[1;34m" PROMPT_DIR_COLOR="\033[1;35m" PROMPT_GIT_STATUS_COLOR="\033[1;36m" PROMPT_SYMBOL_COLOR="\033[1;37m" . .bash_prompt'
	@echo 'TERM='' PROMPT_USER_COLOR="$$(TERM=xterm-256color tput bold)$$(TERM=xterm-256color tput setaf 100)" . .bash_prompt'
	@echo 'exit'

.PHONY: install install-link clean test demo
