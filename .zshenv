# Following line breaks scp !
#echo "sourcing $ZDOTDIR/.zshenv"

if [[ -z $(echo $PATH | grep ~/bin) ]]; then
    export PATH=$PATH:~/bin
fi
export BROWSER=chromium

export VISUAL=vim
export EDITOR=vim
export FILER=spacefm

# Use XDG config dir for vim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"

# Permissions rw-r--r-- pour les fichiers crées
# et rwxr-xr-x pour les répertoires crées
# umask 022 # set by /etc/profile

# Proxy HTTP / FTP sans mot de passe
#export http_proxy="http://proxy.exemple.org:8080"
#export ftp_proxy="ftp://proxy.exemple.org:8080"

# Proxy HTTP / FTP avec mot de passe
#export http_proxy="http://login:password@proxy.exemple.org:8080"
#export ftp_proxy="ftp://login:password@proxy.exemple.org:8080"

# Ne pas passer par le proxy pour les domaines locaux
#export no_proxy="exemple.org"

# De la couleur pour grep
export GREP_OPTIONS='--color=auto'

[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME=$HOME/.config

# Fix Steam'S close button (close -> minimize to tray)
export STEAM_FRAME_FORCE_CLOSE=1

# Fix "QGtkStyle was unable to detect the current GTK+ theme"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# [[ $FBTERM -eq 1 ]] && export TERM=fbterm
#[[ $TERM -eq "fbterm" ]] && fbterm&

#export CHROMIUM_USER_FLAGS="--password-store=gnome"
