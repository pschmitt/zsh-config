export RUNLEVEL=$(runlevel | awk '{ print  $NF }')

#if [[ -z $DISPLAY && $(tty) = "/dev/tty1" && $RUNLEVEL -eq 5 ]]; then
    #pgrep X > /dev/null || { exec startx "xmonad"; logout ; }
#fi

#alsactl -f ~/.asoundrc restore
