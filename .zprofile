# Source the global zprofile
# When setting ZDOTDIR in the global, the global zprofile does not get sourced.
# This breaks LANG among other stuff
source /etc/zsh/zprofile

# Set path
typeset -U path
path+=(~/bin "${GOPATH//://bin:}/bin")

# Start Xorg if currently on first tty
# vt=$(fgconsole 2>/dev/null)
# (( vt == 1 )) && exec startx -- vt$vt
# unset vt
