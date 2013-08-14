#!/usr/bin/env bash

# Install the prompt
# make install

# Set up test constants
EXPECTED_FILE="test/test-files/ps1/expected.txt"

# Get the output of a new shell
ACTUAL_PS1="$(bash -i -c 'echo $PS1; exit 0')"

# # Save a fixture
# echo -n "$ACTUAL_PS1" > "$EXPECTED_FILE"

# Assert the ACTUAL_PS1 matches the expected PS1
EXPECTED_PS1="$(cat $EXPECTED_FILE)"
if [[ "$EXPECTED_PS1" != "$ACTUAL_PS1" ]]; then
  echo "Actual PS1 !== expected PS1: $ACTUAL_PS1 !== $EXPECTED_PS1" 1>&2
  exit 1
fi

# Notify the user of all tests passing
echo "All tests passed!"
exit 0