# echo "sourcing $ZDOTDIR/.zshenv"

#if [[ -z $(echo $PATH | grep ~/bin) ]]; then
#    export PATH=$PATH:~/bin
#fi

export BROWSER=firefox

export VISUAL=vim
export EDITOR=vim
export FILER=pcmanfm

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

# [[ $FBTERM -eq 1 ]] && export TERM=fbterm
#[[ $TERM -eq "fbterm" ]] && fbterm&

