# Setup fzf
# ---------
if [[ ! "$PATH" == */home/pschmitt/.config/zsh/plugins/fzf/bin* ]]; then
  export PATH="$PATH:/home/pschmitt/.config/zsh/plugins/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/pschmitt/.config/zsh/plugins/fzf/man* && -d "/home/pschmitt/.config/zsh/plugins/fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/pschmitt/.config/zsh/plugins/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/pschmitt/.config/zsh/plugins/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/pschmitt/.config/zsh/plugins/fzf/shell/key-bindings.zsh"

