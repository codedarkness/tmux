#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _` | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _` |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.com
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: tmux-dev.sh
#       USAGE: ./tmux-dev.sh
#
# DESCRIPTION: create a new tmux session with new windows and
#	       splits each with diferent programs
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 05-16-2020 10:53
#
# -----------------------------------------------------------------

tmux new-session -d
tmux rename-window 'terminal'

tmux new-window 'ranger'
tmux rename-window 'ranger'

tmux new-window 'vim'

tmux new-window 'w3m duckduckgo.com'

tmux new-window 'mutt'
tmux split-window -h 'calcurse'
tmux split-window -v 'pyradio'
tmux rename-window 'office'

tmux -2 attach-session -d
