# Install the prompt
# make install

# Set up test constants
EXPECTED_FILE="test/test-files/ps1/expected.txt"

# Get the output of a new shell
ACTUAL_PS1="$(bash -i -c 'echo $PS1')"

# # Save a fixture
# echo "$ACTUAL_PS1" > $EXPECTED_FILE

# Assert the ACTUAL_PS1 matches the expected PS1
EXPECTED_PS1="$(cat $EXPECTED_FILE)"
echo "$EXPECTED_PS1"
