# zsh-config

## Installation

``` bash
git clone --recursive https://github.com/pschmitt/zsh-config.git ~/.config/zsh
echo 'export ZDOTDIR="$HOME/.config/zsh"' > /etc/zsh/zshenv
```

## No root acccess?

Paste this to your `$HOME/.zshenv`:

```bash
# Don't load default zshrc
setopt no_global_rcs

# Environmnet variables
export XDG_CONFIG_HOME="$HOME/.config"
# Move zsh config to $XDG_CONFIG_HOME
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# Move vim config to $XDG_CONFIG_HOME
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
```

Single command:

```bash
cat <<EOM > $HOME/.zshenv
# Don't load default zshrc
setopt no_global_rcs

# Environmnet variables
export XDG_CONFIG_HOME="$HOME/.config"
# Move zsh config to $XDG_CONFIG_HOME
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# Move vim config to $XDG_CONFIG_HOME
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
EOM
```
