# Install the prompt
# make install

# Get the output of a new shell
INSTALLED_PS1="$(bash -i -c 'echo $PS1')"

# Save a fixture
echo "$INSTALLED_PS1" > test/test-files/ps1/expected.txt