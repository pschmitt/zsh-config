#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Version:  1.3                                                    #
# Author:   Philipp Schmitt <philipp@schmitt.co>                   #
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
HISTFILE=$XDG_DATA_HOME/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000


#------------------------------
# Init and completion
#------------------------------
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
# Precompile the zsh code so that it would be faster
autoload -U zrecompile
# Completion
autoload -U compinit
compinit
# Expand aliases and use the right completion
# Shouldn't that be completealiases?
setopt no_completealiases

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

# Rehash after pacman/yaourt command
TRAPUSR1() { rehash }
precmd() {
    [[ $history[$[ HISTCMD -1 ]] == (pacman|yaourt|yup|yupnc|ync|yrm|yrf|y -S|y )* ]] && killall -USR1 zsh
}

# Colors
[[ -r $XDG_CONFIG_HOME/LS_COLORS/LS_COLORS ]] && {
    eval $(dircolors -b $XDG_CONFIG_HOME/LS_COLORS/LS_COLORS)
}

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 2 numeric
# activate color-completion¬
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}¬
zstyle ':completion:*:cache-path' $XDG_CACHE_HOME/zsh/zcompcache
# TODO Add use-cache!
zstyle ':completion:*:processes' command 'ps -ax'
zstyle ':completion:*:processes-names' command 'ps -aeo comm='
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:killall:*:processes-names' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:killall:*' menu yes select
# Ignore completion functions for commands you don’t have
zstyle ':completion:*:functions' ignored-patterns '_*'

compctl -k "(count debug primary secondary tertiary toggle extend copy)" xrdr

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
setopt share_history                            # share command history data between shells
setopt correct                                  # spell check for commands only
setopt autocd                                   # automatically cd to paths
setopt extendedglob
setopt interactivecomments                      # Allow comments in interactive mode
setopt NOclobber                                # echo "test" > file: warn if file exists (Force: !>)
#unsetopt bgnice                                 # don't nice bg command
setopt autoparamslash                         #
setopt autoremoveslash
#unsetopt beep                                   # disable beep


#------------------------------
# Keybindings
#------------------------------
bindkey -v
zmodload zsh/terminfo

autoload -Uz narrow-to-region
_history-incremental-preserving-pattern-search-backward() {
  local state
  MARK=CURSOR  # magick, else multiple ^R don't work
  narrow-to-region -p "$LBUFFER${BUFFER:+>>}" -P "${BUFFER:+<<}$RBUFFER" -S state
  zle end-of-history
  zle history-incremental-pattern-search-backward
  narrow-to-region -R state
}
zle -N _history-incremental-preserving-pattern-search-backward
bindkey '^R' _history-incremental-preserving-pattern-search-backward
bindkey -M isearch "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
# Ctrl-Backspace to remove previous word
bindkey "^H" backward-kill-word
# Ctrl-Delete to remove next word
bindkey '^[[33~' kill-word


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
    rxvt-unicode-256color)
        bindkey '^[Oc' forward-word  # ctrl-right
        bindkey '^[Od' backward-word # ctrl-left
        ;;
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

# Undo/Redo
bindkey '^[z' undo # alt-z
bindkey '^[y' redo # alt-y

# ctrl-x t to play tetris
bindkey "^Xt" tetris

# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix # ctrl-i

# file rename magic
bindkey "^[m" copy-prev-shell-word # alt-m


#------------------------------
# Source config files
#------------------------------
for file in ${ZDOTDIR}/{zaliases,zfunctions,zprompt}; do
    . $file || { print "$file: cannnot source file" && setopt warncreateglobal }
done

# Host specific config
for file in ${ZDOTDIR}/hosts/${HOST}/{zaliases,zfunctions,zprompt}; do
    [[ -r $file ]] && . $file
done


#------------------------------
# Plugins
#------------------------------
# Syntax highlighting
. ${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autoenv
. ${ZDOTDIR}/plugins/autoenv/activate.sh

# z
_Z_DATA=$XDG_DATA_HOME/zsh/z
. ${ZDOTDIR}/plugins/z/z.sh

# Mouse support
# . ${ZDOTDIR}/plugins/mouse.zsh
# zle-toggle-mouse

# fish-like history search using <Up|Down>
. ${ZDOTDIR}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

[[ -n "${terminfo[kcuu1]}" ]] && bindkey "$terminfo[kcuu1]" history-substring-search-up
[[ -n "${terminfo[kcud1]}" ]] && bindkey "$terminfo[kcud1]" history-substring-search-down

# fzf
. ${ZDOTDIR}/plugins/fzf.zsh

# FIXME: Why do we need these?!
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


