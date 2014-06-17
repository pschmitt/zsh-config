# TODO Only try to create all dirs once (how does gkrm achieve this?)
# This would be like an "install" function with a lock
# Maybe there is a buildin ZSH thing we can rely on since ZSH knows when
# it is run for the first time
# This would increase performance/responsiveness

# Following line breaks scp !
#echo "sourcing $ZDOTDIR/.zshenv"

# Ignore global rc files
setopt NO_GLOBAL_RCS

typeset -U path
path=(~/bin $path)

# Make sure XDG dirs are set
[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME=$HOME/.config
[[ -n "$XDG_CACHE_HOME"  ]] || export XDG_CACHE_HOME=$HOME/.cache
[[ -n "$XDG_DATA_HOME"   ]] || export XDG_DATA_HOME=$HOME/.local/share

# Decrease key input delay to 10ms
export KEYTIMEOUT=1

# Remove '/' from wordchars to allow word deletion on files
export WORDCHARS=$(sed 's|/||' <<< $WORDCHARS)

# Use XDG config dir for vim
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"
export VIMINIT='let $VIMRC="$VIMDOTDIR/vimrc" | source $VIMRC'
export VIMPAGER_RC="$VIMDOTDIR/vimpagerrc"
export VIMPERATOR_RUNTIME="$XDG_CONFIG_HOME/vimperator"
export VIMPERATOR_INIT=":source $VIMPERATOR_RUNTIME/vimperatorrc"
export PENTADACTYL_RUNTIME="$XDG_CONFIG_HOME/pentadactyl"
export PENTADACTYL_INIT=":source $PENTADACTYL_RUNTIME/pentadactylrc"

# More XDG hacks
export RXVT_SOCKET=$XDG_DATA_HOME/urxvt/urxvt-$HOST
[[ ! -d $(dirname $RXVT_SOCKET) ]] && mkdir $(dirname $RXVT_SOCKET)
export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer

# Common apps
export BROWSER=firefox
export EDITOR=vim
export VISUAL=$EDITOR
export FILER=spacefm
export PAGER=vimpager
export MANPAGER=$PAGER

# Non standard?
export TERMINAL=urxvtc

# Always use colors with grep
export GREP_OPTIONS='--color=auto'

# Fix Steam's close button (close -> minimize to tray)
export STEAM_FRAME_FORCE_CLOSE=1

# TODO Move to $XDG_CONFIG_HOME
# Fix "QGtkStyle was unable to detect the current GTK+ theme"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# [[ $FBTERM -eq 1 ]] && export TERM=fbterm
# [[ $TERM -eq "fbterm" ]] && fbterm&

# Chrome options
# export CHROMIUM_USER_FLAGS="--password-store=gnome"

# virtualenvwrapper
export WORKON_HOME=$XDG_DATA_HOME/venv
[[ -d $WORKON_HOME ]] || mkdir -p "$WORKON_HOME"
# Uncomment this to use python2 by default
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
source /usr/bin/virtualenvwrapper.sh

# Default permissions
# umask 022

# Proxy HTTP / FTP w/o password
# export http_proxy="http://proxy.exemple.org:8080"
# export ftp_proxy="ftp://proxy.exemple.org:8080"

# Proxy HTTP / FTP with password
# export http_proxy="http://login:password@proxy.exemple.org:8080"
# export ftp_proxy="ftp://login:password@proxy.exemple.org:8080"

# Skip proxy for specific hosts
# export no_proxy="exemple.org"

