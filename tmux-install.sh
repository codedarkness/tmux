#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.xyz
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: tmux-install.sh
#       USAGE: ./tmux-install.sh
#
# DESCRIPTION: install tmux and copy custom files
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 05-15-2020 09:39
#
# -----------------------------------------------------------------

install-tmux() {
	echo ""
	echo " Install tmux"
	echo " Arch Linux | Debian | Void Linux"
	echo ""
	sleep 2

	while true; do
		read -p " Install tmux [y - n] : " yn
		case $yn in
			[Yy]* )
				if ! location="$(type -p "tmux")" || [ -z "tmux" ]; then

					# check if pacman is installed
					if which pacman > /dev/null 2>&1; then

						sudo pacman -S --noconfirm tmux

					# check if apt is installed
					elif which apt > /dev/null 2>&1; then

						sudo apt install -y tmux

					# check if xbps is installed
					elif which xbps-install > /dev/null 2>&1; then

						sudo xbps-install -Sy tmux
					else

						echo " Your system is not compatible with this script..."
					fi

					else
						echo " Nothing to do! tmux is installed in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo ""
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
	echo " 2 - Copy (custom) files"
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
