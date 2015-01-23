# sexy-bash-prompt [![Build status](https://travis-ci.org/twolfson/sexy-bash-prompt.png?branch=master)](https://travis-ci.org/twolfson/sexy-bash-prompt)

[Bash][bash] prompt with colors, git statuses, and git branches.

Providing a unique symbol for every combination of a dirty, unpulled, and unpushed `git` branch.

![sexy-bash-prompt screenshot][screenshot]

[screenshot]: screenshot.png

Forked from [a gist by gf3][sexy-bash-orig].

[sexy-bash-orig]: https://gist.github.com/gf3/306785/a35d28b6bdd0f7c54318cce510738438f04dabaa

### Do you like `sexy-bash-prompt`?
[Support us via gratipay][gratipay] or [spread word on Twitter][twitter]

[gratipay]: https://gratipay.com/sexybashprompt/
[twitter]: https://twitter.com/intent/tweet?text=Bash%20prompt%20with%20colors%2C%20git%20statuses%2C%20and%20git%20branches&url=https%3A%2F%2Fgithub.com%2Ftwolfson%2Fsexy-bash-prompt&via=sexybashprompt

## Installation
One line install:

```bash
(cd /tmp && git clone --depth 1 https://github.com/twolfson/sexy-bash-prompt && cd sexy-bash-prompt && make install) && source ~/.bashrc
```

### My colors don't look as advertised
If you are seeing a screen like this:

![Bad TERM config](docs/bad_term.png)

Then, your `TERM` environment variable may never have been configured. Run the script below to prefix our prompt with a `TERM` setup

```bash
cat > /tmp/.bash_prompt_term <<EOF
#!/usr/bin/env bash
# Determine what type of terminal we are using for \`tput\`
if [[ \$COLORTERM = gnome-* && \$TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then export TERM=gnome-256color
elif [[ \$TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
fi

EOF
chmod +x /tmp/.bash_prompt_term
cat ~/.bash_prompt >> /tmp/.bash_prompt_term
cp /tmp/.bash_prompt_term ~/.bash_prompt
rm /tmp/.bash_prompt_term
```

### Manual install
```bash
$ # Clone the repository
$ git clone --depth 1 https://github.com/twolfson/sexy-bash-prompt
Cloning into 'sexy-bash-prompt'...
...
Resolving deltas: 100% (13/13), done.
$ # Go into the directory
$ cd sexy-bash-prompt
$ # Install the script
$ make install
# Copying .bash_prompt to ~/.bash_prompt
cp --force .bash_prompt ~/.bash_prompt
# Adding ~/.bash_prompt to ~/.bashrc
echo ". ~/.bash_prompt" >> ~/.bashrc
# twolfson/sexy-bash-prompt installation complete!
$ # Rerun your ~/.bashrc
$ source ~/.bashrc
todd at Euclid in ~/github/sexy-bash-prompt on master
$ # Your PS1 should now look like this!
```

## Configuration
### Colors
Colors can be customized by editing `.bash_prompt` directly, or by setting the following environment variables:

- `PROMPT_USER_COLOR` - Color for username (e.g. `todd`)
- `PROMPT_PREPOSITION_COLOR` - Color for 'at', 'in', 'on'
- `PROMPT_DEVICE_COLOR` - Color for machine name (e.g. `Euclid`)
- `PROMPT_DIR_COLOR` - Color for directory (e.g. `~/github/sexy-bash-prompt`)
- `PROMPT_GIT_STATUS_COLOR` - Color for git branch and symbol (e.g. `master`)
- `PROMPT_GIT_PROGRESS_COLOR` - Color for in progress git actions (e.g. `[merge]`)
- `PROMPT_SYMBOL_COLOR` - Color for prompt symbol (e.g. `$`)

You can set colors via [`tput`][] or [ANSI escape codes][]. For example:

[`tput`]: http://en.wikipedia.org/wiki/Tput
[ANSI escape codes]: http://en.wikipedia.org/wiki/ANSI_escape_code

```bash
# Inside your `.bashrc` or `.bash_profile`
PROMPT_USER_COLOR="$(tput bold)$(tput setaf 9)" # BOLD RED
source ~/.bash_prompt
```

![Color overridden prompt](docs/color_override.png)

### Symbols
Similarly, symbols can be customized with the following environment variables:

- `PROMPT_SYNCED_SYMBOL` - Symbol for clean and synced branch (e.g. empty string)
- `PROMPT_DIRTY_SYNCED_SYMBOL` - Symbol for dirty and synced branch (e.g. `*`)
- `PROMPT_UNPUSHED_SYMBOL` - Symbol for unpushed branch (e.g. `△`)
- `PROMPT_DIRTY_UNPUSHED_SYMBOL` - Symbol for dirty and unpushed branch (e.g. `▲`)
- `PROMPT_UNPULLED_SYMBOL` - Symbol for unpulled branch (e.g. `▽`)
- `PROMPT_DIRTY_UNPULLED_SYMBOL` - Symbol for dirty and unpulled branch (e.g. `▼`)
- `PROMPT_UNPUSHED_UNPULLED_SYMBOL` - Symbol for dirty and unpulled branch (e.g. `⬡`)
- `PROMPT_DIRTY_UNPUSHED_UNPULLED_SYMBOL` - Symbol for dirty, unpushed, and unpulled branch (e.g. `⬢`)

```bash
# Inside your `.bashrc` or `.bash_profile`
PROMPT_UNPUSHED_SYMBOL="↑"
source ~/.bash_prompt
```

![Symbol overridden prompt](docs/symbol_override.png)

#### Compatibility
In some situations, the default symbol set can be drawn incorrectly (e.g. as diamonds). To remedy that, a simpler set of symbols can be used:

```bash
PROMPT_SYNCED_SYMBOL=""
PROMPT_DIRTY_SYNCED_SYMBOL="*"
PROMPT_UNPUSHED_SYMBOL="↑"
PROMPT_DIRTY_UNPUSHED_SYMBOL="*↑"
PROMPT_UNPULLED_SYMBOL="↓"
PROMPT_DIRTY_UNPULLED_SYMBOL="*↓"
PROMPT_UNPUSHED_UNPULLED_SYMBOL="*↑↓"
PROMPT_DIRTY_UNPUSHED_UNPULLED_SYMBOL="*↑↓"
```

## How does it work?
[bash][bash] provides a special set of [variables for your prompts][ps-vars]. `PS1` is the one used by default. The install script adds a command to `~/.bashrc`, a file that is run every time a new terminal opens. Inside of the new command, we run our script and set your `PS1` which runs some `git` commands to determine its current state and outputs them as a string.

[bash]: https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29
[ps-vars]: http://www.gnu.org/software/bash/manual/bashref.html#index-PS1

## Support
Linux and Mac OSX are supported platforms.

Windows is supported to the best of my abilities. However, there have been [font issues][putty-issue] with using [PuTTY][].

[PuTTY]: http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html
[putty-issue]: https://github.com/twolfson/sexy-bash-prompt/issues/7

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Test via `make test`.

## License
Copyright (c) 2013 Todd Wolfson

Licensed under the MIT license.
