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

# # # Output our symbols from their hex equivalents
# echo -e "\xE2\xAC\xA2" # Filled hexagon # In getty, diamond
# echo -e "\xE2\x96\xB2" # Filled up triangle # In getty, up arrow
# echo -e "\xE2\x96\xBC" # Filled down triangle # In getty, down arrow
# echo -e "\xE2\xAC\xA1" # Empty hexagon # In getty, diamond
# echo -e "\xE2\x96\xB3" # Empty up triangle # In getty, diamond
# echo -e "\xE2\x96\xBD" # Empty down triangle # In getty, diamond
# echo -e "\x2A" # Asterisk # In getty, asterisk

# # $ echo -n "↑" | hexdump -C
# # 00000000  e2 86 91                                          |...|
# # 00000003
# # todd at Euclid in ~/github/sexy-bash-prompt on dev/explore.unicode*
# # $ echo -n "˄" | hexdump -C
# # 00000000  cb 84                                             |..|
# # 00000002

# echo -e "\xE2\x86\x91" # Works but not sure why such a high range one does
# echo -e "\xE2\x86" # Doesn't work
# echo -e "\xE2\x91" # Doens't work
# echo -e "\x86\x91" # Doens't work
# echo -e "\xE2" # Doens't work
# echo -e "\x86" # Doens't work
# echo -e "\x91" # Doens't work
# # echo -e "\xCB\x84" # Doesn't work

# # http://unix.stackexchange.com/questions/15139/how-to-print-all-printable-ascii-chars-in-cli
# for ((i=32;i<=512;i++)); do
#   printf "\\$((i/64*100+i%64/8*10+i%8))\t";
# done

# http://stackoverflow.com/questions/5517500/simple-shell-script-for-generating-hex-numbers-of-a-certain-range
# http://www.utf8-chartable.de/
hex_range () {
  from="$1"
  to="$2"
  for i in $(seq "$(printf "%d" "0x$from")" "$(printf "%d" "0x$to")"); do
    printf "%02X\n" "$i"
  done
}

# ASCII sans control (20-7E)
for i in $(hex_range 20 7E); do
  echo "$(echo -e "$i: \x${i}")"
done

# Output C2 A0-BF
i="C2"
for j in $(hex_range A0 BF); do
  echo "$(echo -e "$i $j: \x${i}\x${j}")"
done

# Output C3-DF 80-BF
for i in $(hex_range C3 DF); do
  for j in $(hex_range 80 BF); do
    echo "$(echo -e "$i $j: \x${i}\x${j}")"
  done
done

# Output E0-EF A0-BF 80-BF
for i in $(hex_range E0 EF); do
  for j in $(hex_range A0 BF); do
    for k in $(hex_range 80 BF); do
      echo "$(echo -e "$i $j $k: \x${i}\x${j}\x${k}")"
    done
  done
done

# wtf, D0 BB is an arrow in `getty`

# The first 4 work in getty as arrows
# echo -e "\xE2\x86\x90"
# echo -e "\xE2\x86\x91"
# echo -e "\xE2\x86\x92"
# echo -e "\xE2\x86\x93"
# echo -e "\xE2\x86\x94"
