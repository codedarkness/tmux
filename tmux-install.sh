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

arch-based() {
	echo "";
	echo " Installing tmux - ArchBased systems"
	sleep 2;
	pacman -Qs tmux &&
		echo " tmux is installed in your system" ||
		sudo pacman -S --noconfirm -needed tmux
}

debian-based() {
	echo "";
	echo " Installing tmux - DebianBased systems"
	sleep 2;
	dpkg -l | grep tmux &&
		echo " tmux is installed in your system" ||
		sudo apt install -y tmux
}

config-files() {
	echo ""
	echo " Copy custom files";
	cp -ar config-files/tmux.conf $HOME/.tmux.conf &&
		echo " tmux.conf was copied";
	cp -ar config-files/tmux-dev.sh $HOME/tmux-dev.sh &&
		echo " custom tmux-dev was copied";
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
	echo " ------------------------------"
	echo " ### a terminal multiplexer ###"
	echo " ------------------------------"
	echo ""
	echo " 1 - Install in Arch Based"
	echo " 2 - Install in Debian Based"
	echo " 3 - Copy (custom) config files"
	echo " 4 - Keybindings"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; arch-based   ; press_enter ;;
		2) clear; debian-based ; press_enter ;;
		3) clear; config-files ; press_enter ;;
		4) clear; keybindings ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
