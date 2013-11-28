#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Version:  1.2                                                    #
# Author:   Philipp Schmitt <attentah@gmail.com>                   #
#------------------------------------------------------------------#
#      _________  _   _ ____   ____
#     |__  / ___|| | | |  _ \ / ___|
#       / /\___ \| |_| | |_) | |
#  _   / /_ ___) |  _  |  _ <| |___
# (_) |____|____/|_| |_|_| \_\\____|
#


#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

# Mouse support
# . ~/temp/mouse.zsh
# zle-toggle-mouse



#------------------------------
# Init and completion
#------------------------------
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -U compinit
compinit
setopt completealiases

setopt autopushd
setopt pushdminus
#setopt pushd_ignore_dups

autoload -U colors && colors
# zsh's equivalent of /dev/tcp (bash)
# autoload -U tcp_open

# Autocorrection
setopt correctall

# Auto-Rehash ?
_force_rehash() {
    (( CURRENT == 1 )) && rehash
        return 1 # Because we didn't really complete anything
}

zstyle ':completion:*' completer _force_rehash _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle ':completion:*:processes' command 'ps -ax'
zstyle ':completion:*:processes-names' command 'ps -aeo comm='
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:killall:*:processes-names' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:killall:*' menu yes select

compctl -k "(count debug primary secondary tertiary toggle extend copy)" xrdr
compdef '_files -W /etc/rc.d' start stop restart

autoload -U promptinit
promptinit

# auto escape special chars
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

autoload -U tetris
zle -N tetris

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line



#------------------------------
# Options
#------------------------------
setopt extended_history                         # history with begin time, duration of command and command
setopt hist_ignore_dups                         # don't save duplicate commands
setopt hist_find_no_dups                        # do not print duplicates in history
setopt hist_reduce_blanks                       # reduce whitespace in history
setopt hist_save_no_dups                        # older commands that duplicate newer ones are omitted
setopt hist_verify                              # 
#setopt inc_append_history                       # append to histfile instead of rewriting it (multiple shells)
setopt share_history                             # share command history data between shells
setopt correct                                  # spell check for commands only
setopt autocd                                   # automatically cd to paths
setopt extendedglob
#unsetopt bgnice                                 # don't nice bg command
#unsetopt autoparamslash                         #
#unsetopt beep                                   # disable beep



#------------------------------
#c Keybindings
#------------------------------
bindkey -v

autoload -Uz narrow-to-region
_history-incremental-preserving-pattern-search-backward() {
  local state
  MARK=CURSOR  # magick, else multiple ^R don't work
  narrow-to-region -p "$LBUFFER${BUFFER:+>> }" -P "${BUFFER:+ <<}$RBUFFER" -S state
  zle end-of-history
  zle history-incremental-pattern-search-backward
  narrow-to-region -R state
}
zle -N _history-incremental-preserving-pattern-search-backward
bindkey "^R" _history-incremental-preserving-pattern-search-backward
bindkey -M isearch "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

<<<<<<< HEAD
case $TERM in
xterm-256color)
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[2~' overwrite-mode
bindkey '\e[5~' beginning-of-buffer-or-history
bindkey '\e[6~' end-of-buffer-or-history
bindkey '\e[3~' delete-char
bindkey '\eOc'  forward-word        	# ctrl cursor right
bindkey '\eOd'  backward-word	    	# ctrl cursor left
;;
screen-256color)
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[2~' overwrite-mode
bindkey '\e[3~' delete-char
bindkey '\e[5~' beginning-of-buffer-or-history
bindkey '\e[6~' end-of-buffer-or-history
bindkey '^R'    history-incremental-search-backward # Right-Ctrl + R
#bindkey '^U' undo
#bindkey '^R' redo
;;
screen.linux)
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[2~' overwrite-mode
bindkey '\e[3~' delete-char
bindkey '\e[5~' beginning-of-buffer-or-history
bindkey '\e[6~' end-of-buffer-or-history
;;
linux)
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[2~' overwrite-mode
bindkey '\e[3~' delete-char
bindkey '\e[5~' beginning-of-buffer-or-history
bindkey '\e[6~' end-of-buffer-or-history
;;
rxvt-unicode-256color)
bindkey '\e[7~' beginning-of-line       # home
bindkey '\e[8~' end-of-line             # end
bindkey '\eOc'  forward-word            # ctrl cursor right
bindkey '\eOd'  backward-word           # ctrl cursor left
bindkey '\e[3~' delete-char	            # This should not be necessary !
bindkey '\e[2~' overwrite-mode	    	# Insert
[[ -n "${terminfo[khome]}" ]] && bindkey "${terminfo[khome]}" beginning-of-line    # Home
[[ -n "${terminfo[kend]}"  ]] && bindkey "${terminfo[kend]}"  end-of-line          # End
[[ -n "${terminfo[kich1]}" ]] && bindkey "${terminfo[kich1]}" overwrite-mode       # Insert
[[ -n "${terminfo[kdch1]}" ]] && bindkey "${terminfo[kdch1]}" delete-char          # Delete
#[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" up-line-or-history   # Up
#[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" down-line-or-history # Down
[[ -n "${terminfo[kcub1]}" ]] && bindkey "${terminfo[kcub1]}" backward-char        # Left
[[ -n "${terminfo[kcuf1]}" ]] && bindkey "${terminfo[kcuf1]}" forward-char         # Right
[[ -n "${terminfo[kpp]}"   ]] && bindkey "${terminfo[kpp]}"   beginning-of-buffer-or-history # PageUp
[[ -n "${terminfo[knp]}"   ]] && bindkey "${terminfo[knp]}"   end-of-buffer-or-history       # PageDown

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
# if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#     function zle-line-init () {
#         printf '%s' "${terminfo[smkx]}"
#     }
#     function zle-line-finish () {
#         printf '%s' "${terminfo[rmkx]}"
#     }
#     zle -N zle-line-init
#     zle -N zle-line-finish
# fi

case $TERM in
    rxvt-unicode-256color) ;&
    xterm-256color)
        bindkey '\eOc' forward-word  # ctrl-right
        bindkey '\eOd' backward-word # ctrl-left
        ;;
    xterm)
        bindkey '^[[1;5C' forward-word  # ctrl-right
        bindkey '^[[1;5D' backward-word # ctrl-left
        ;;
    screen-256color)
        bindkey '^[OC' forward-word  # ctrl-right
        bindkey '^[OD' backward-word # ctrl-left
        ;;
    screen.linux)
        # TODO
        ;;
    linux)
        bindkey '^[[C' forward-word  # ctrl-right
        bindkey '^[[D' backward-word # ctrl-left
        ;;
esac

bindkey "^Xt" tetris ## C-x t to play

# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

## file rename magic (alt+m)
bindkey "^[m" copy-prev-shell-word

# Colors
eval $(dircolors -b $XDG_CONFIG_HOME/LS_COLORS/LS_COLORS)

#------------------------------
# Source config files
#------------------------------
for file in ${ZDOTDIR}/{zaliases,zfunctions,zprompt}; do
    # Following line breaks scp !
    #echo "sourcing $file"
    . $file || { print "$file: cannnot source file" && setopt warncreateglobal }
done

# Host specific config
for file in ${ZDOTDIR}/{zaliases_${HOST},zfunctions_${HOST},zprompt_${HOST}}; do
    [[ -r $file ]] && . $file
done


#------------------------------
# Plugins
#------------------------------
# Syntax highlighting
. ${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Mouse support
. ${ZDOTDIR}/plugins/mouse.zsh
zle-toggle-mouse

# fish-like history search using <Up|Down>
. ${ZDOTDIR}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

[[ -n "${terminfo[kcuu1]}" ]] && bindkey "$terminfo[kcuu1]" history-substring-search-up
[[ -n "${terminfo[kcud1]}" ]] && bindkey "$terminfo[kcud1]" history-substring-search-down

# Why do we need these?!
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
