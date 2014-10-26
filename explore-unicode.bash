#!/usr/bin/env bash
# http://stackoverflow.com/questions/602912/how-do-you-echo-a-4-digit-unicode-character-in-bash
# Grab the hex values for our current set of symbols
# echo -n "⬢" | hexdump -C; # 00000000  e2 ac a2
# echo -n "▲" | hexdump -C; # 00000000  e2 96 b2
# echo -n "▼" | hexdump -C; # 00000000  e2 96 bc
# echo -n "⬡" | hexdump -C; # 00000000  e2 ac a1
# echo -n "△" | hexdump -C; # 00000000  e2 96 b3
# echo -n "▽" | hexdump -C; # 00000000  e2 96 bd
# echo -n "*" | hexdump -C; # 00000000  2a

# # Output our symbols from their hex equivalents
echo -e "\xE2\xAC\xA2" # Filled hexagon # In getty, diamond
echo -e "\xE2\x96\xB2" # Filled up triangle # In getty, up arrow
echo -e "\xE2\x96\xBC" # Filled down triangle # In getty, down arrow
echo -e "\xE2\xAC\xA1" # Empty hexagon # In getty, diamond
echo -e "\xE2\x96\xB3" # Empty up triangle # In getty, diamond
echo -e "\xE2\x96\xBD" # Empty down triangle # In getty, diamond
echo -e "\x2A" # Asterisk # In getty, asterisk

# $ echo -n "↑" | hexdump -C
# 00000000  e2 86 91                                          |...|
# 00000003
# todd at Euclid in ~/github/sexy-bash-prompt on dev/explore.unicode*
# $ echo -n "˄" | hexdump -C
# 00000000  cb 84                                             |..|
# 00000002

echo -e "\xE2\x86\x91" # Works but not sure why such a high range one does
echo -e "\xE2\x86" # Doesn't work
echo -e "\xE2\x91" # Doens't work
echo -e "\x86\x91" # Doens't work
echo -e "\xE2" # Doens't work
echo -e "\x86" # Doens't work
echo -e "\x91" # Doens't work
# echo -e "\xCB\x84" # Doesn't work
