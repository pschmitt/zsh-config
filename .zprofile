# Source the global zprofile
# When setting ZDOTDIR in the global, the global zprofile does not get sourced.
# This breaks LANG among other stuff
source /etc/zsh/zprofile

# set up $PATH
source "${ZDOTDIR}/.pathrc"

# Start X11
# source "${ZDOTDIR}/.zstartx"
