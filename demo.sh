# Sexy bash prompt demo
# Walks to the next directory in our list

# Save the TEST_DIR for reference
TEST_DIR="test/test-files"

# If we are already in a test directory, use ../
if test -n "$(echo $PWD | grep 'test-files')"; then
  TEST_DIR=".."
fi

# Navigate through the test directories
USE_NEXT_DIR=""
TARGET_DEMO_DIR=""
for DEMO_DIR in "clean-synced" "dirty" "unpushed" "dirty-unpushed" "unpulled" "dirty-unpulled" "unpushed-unpulled" "dirty-unpushed-unpulled"; do
  # If we should use this directory, navigate to it
  if test -n "$USE_NEXT_DIR"; then
    TARGET_DEMO_DIR="$DEMO_DIR"
    break
  fi

  # If the current directory was the last one, mark us to use the next one
  # echo $PWD
  if test -n "$(echo $PWD | grep -E \/${DEMO_DIR}$)"; then
    USE_NEXT_DIR="1"
  fi
done

# If no directories were matching, move to the start directory
if test -z "$TARGET_DEMO_DIR"; then
  TARGET_DEMO_DIR="clean-synced"
fi

# Move to the directory
echo "$TEST_DIR"/"$TARGET_DEMO_DIR"