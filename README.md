# sexy-bash-prompt [![Donate on Gittip](http://badgr.co/gittip/twolfson.png)](https://www.gittip.com/twolfson/)

Beautiful and sexy bash prompt with colors, git statuses, and git branches.

![sexy-bash-prompt screenshot][screenshot]

[screenshot]: screenshot.png

Forked from [a gist by gf3][sexy-bash-orig].

[sexy-bash-orig]: https://gist.github.com/gf3/306785/a35d28b6bdd0f7c54318cce510738438f04dabaa

## Installation
One line install:

```shell
(cd /tmp && git clone --depth 1 https://github.com/twolfson/sexy-bash-prompt && cd sexy-bash-prompt && make install) && source ~/.bashrc
```

Manual install:

```shell
$ # Clone the repository
$ git clone --depth 1 https://github.com/twolfson/sexy-bash-prompt
Cloning into 'sexy-bash-prompt'...
...
Resolving deltas: 100% (13/13), done.
$ # Go into the directory
$ cd sexy-bash-prompt
$ # Install the script
$ make install
# Copying .bashrc to ~/.bash_prompt
cp --force .bashrc ~/.bash_prompt
# Adding ~/.bash_prompt to ~/.bashrc
echo ". ~/.bash_prompt" >> ~/.bashrc
# twolfson/sexy-bash-prompt installation complete!
$ # Rerun your ~/.bashrc
$ source ~/.bashrc
```

## How does it work?
[bash][bash] provides a special set of [variables for your prompts][ps-vars]. `PS1` is the one used by default. The install script adds a command to `~/.bashrc`, a file that is run every time a new terminal opens. Inside of the new command, we run our script and set your `PS1` which runs some `git` commands to determine its current state and outputs them as a string.

[bash]: https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29
[ps-vars]: http://www.gnu.org/software/bash/manual/bashref.html#index-PS1

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Test via `make test`.

## License
Copyright (c) 2013 Todd Wolfson

Licensed under the MIT license.
