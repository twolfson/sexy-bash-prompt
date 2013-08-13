# If were are not on the bleeding edge git
if [[ "$GIT_PPA" != "ppa:pdoes/ppa" ]]; then
  # then use the Ubuntu one
  sudo apt-get install ppa-purge -y
  sudo ppa-purge "ppa:pdoes/ppa" -y
fi