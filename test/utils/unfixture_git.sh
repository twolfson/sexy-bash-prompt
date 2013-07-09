# Find all ".git" directories
for DOTGIT_DIR in $(find test/test-files -path "*/.git"); do
  # Find the target directory
  TARGET_DOTGIT_DIR="$(dirname $DOTGIT_DIR)"/dotgit

  # Move over the directories
  echo "Moving $DOTGIT_DIR to $TARGET_DOTGIT_DIR"
  mv $DOTGIT_DIR $TARGET_DOTGIT_DIR
done