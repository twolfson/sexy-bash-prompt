TEST_DIRS := $(notdir $(wildcard test/test-files/*))
DOTGIT_DIRS := $(wildcard test/test-files/*/dotgit)
GIT_DIRS := $(wildcard test/test-files/*/.git)

install:
	@echo "# Copying .bash_prompt to ~/.bash_prompt"
	cp -f .bash_prompt ~/.bash_prompt

	@# Run install script
	./install.sh

	@echo "# twolfson/sexy-bash-prompt installation complete!"
	exit 0

install-link:
	@echo "# Linking .bash_prompt to ~/.bash_prompt"
	ln -f -s $(PWD)/.bash_prompt $(HOME)/.bash_prompt

	@# Run install script
	./install.sh

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
	@echo "cd /tmp/git/clean-synced"
	@echo "cd /tmp/git/dirty"
	@echo "cd /tmp/git/unpushed"
	@echo "cd /tmp/git/dirty-unpushed"
	@echo "cd /tmp/git/unpulled"
	@echo "cd /tmp/git/dirty-unpulled"
	@echo "cd /tmp/git/unpushed-unpulled"
	@echo "cd /tmp/git/dirty-unpushed-unpulled"
	@echo '"""'

.PHONY: install install-link clean test demo
