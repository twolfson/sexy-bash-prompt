#!/usr/bin/env bash
# http://stackoverflow.com/questions/602912/how-do-you-echo-a-4-digit-unicode-character-in-bash
# Output our filled hexagon
# echo -n "⬢" | hexdump -C; # 00000000  e2 ac a2
echo -e "\xE2\xAC\xA2"
