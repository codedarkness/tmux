#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.com
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: tmux-install.sh
#       USAGE: ./tmux-install.sh
#
# DESCRIPTION: install tmux and copy custom files
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 05-15-2020 09:39
#
# -----------------------------------------------------------------

install-tmux() {
	echo ""
	echo " Install tmux in Arch, Debian based systems"
	echo ""
	sleep 2


	if ! location="$(type -p "tmux")" || [ -z "tmux" ]; then

		# check if pacman is installed
		if which pacman > /dev/null; then

			sudo pacman -S --noconfirm --needed tmux

		fi

		# check if apt is installed
		if which apt > /dev/null; then

			sudo apt install -y tmux

		fi

	else
		echo " nothing to do!"
	fi
}

config-files() {
	echo ""
	echo " Copy custom files"
	echo ""
	sleep 2

	cp -ar config-files/configs/tmux.conf $HOME/.tmux.conf &&
	echo " tmux.conf was copied" || echo " Upssss!!!"
	echo ""

	cp -ar config-files/configs/tmux-dev.sh $HOME/tmux-dev.sh &&
	echo " custom tmux-dev was copied" || echo " It's better if you reformat your pc!!"
	echo ""

	echo " in your terminal run from home directory ./tmux-dev.sh"
}

keybindings() {
	less config-files/keybindings
}

press_enter() {
	echo ""
	echo -n " Press Enter To Continue"
	read
	clear
}

incorrect_selection() {
	echo " Incorrect selection! try again"
}

until [ "$selection" = "0" ]; do
	clear
	echo ""
	echo " DarknessCode"
	echo "  _                         "
	echo " | |                        "
	echo " | |_ _ __ ___  _   ___  __ "
	echo " | __| '_ ' _ \| | | \ \/ / "
	echo " | |_| | | | | | |_| |>  <  "
	echo "  \__|_| |_| |_|\__,_/_/\_\ "
	echo ""
	echo " a terminal multiplexer"
	echo ""
	echo " 1 - Install tmux"
	echo " 2 - Copy (custom) config files"
	echo " 3 - Keybindings"
	echo ""
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install-tmux  ; press_enter ;;
		2) clear; config-files  ; press_enter ;;
		3) clear; keybindings  ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
