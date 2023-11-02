#!/usr/bin/env bash
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

_user="$USER"
_os="$(cat /etc/os-release | grep PRETTY_NAME | cut -d = -f 2 | tr -d '"')"

## Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
END="\e[0m"

install-tmux() {
	echo -e "Installing ${RED}tmux${END} multiplexer"
	echo -e "${YELLOW}$_os${END}"
	echo ""
	sleep 2

	while true; do
		read -p "Install tmux [y - n] : " yn
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
						echo -e "${RED}Your system is not compatible with this script...${END}"
					fi
					else
						echo -e "Nothing to do! ${GREEN}tmux is installed${END} in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

uninstall-tmux() {
	echo -e "Un-Installing ${RED}tmux${END} multiplexer"
	echo -e "${YELLOW}$_os${END}"
	echo ""
	sleep 2

	while true; do
		read -p "unistall tmux [y - n] : " yn
		case $yn in
			[Yy]* )
				if location="$(type -p "tmux")" || [ -z "tmux" ]; then
					# check if pacman is installed
					if which pacman > /dev/null 2>&1; then
						sudo pacman -Rs --noconfirm tmux
					# check if apt is installed
					elif which apt > /dev/null 2>&1; then
						sudo apt remove --purge -y tmux
					# check if xbps is installed
					elif which xbps-install > /dev/null 2>&1; then
						sudo xbps-remove -f tmux
					else
						echo -e "${RED}Your system is not compatible with this script...${END}"
					fi
					else
						echo -e "Nothing to do! ${RED}tmux is not installed${END} in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

config-files() {
	echo -e "${BLUE}Copy Custom Files${END}"
	echo ""
	sleep 2

	[ ! -d "$HOME/.config/tmux" ] && mkdir -p $HOME/.config/tmux && echo -e "${GREEN}tmux directory in .config${END} Created" || echo -e "${RED}LinuxSucks${END}....."

	declare -A directories
	directories[tmux-sys]="config-files/tmux-sys $HOME/.config"
	directories[tmux-temp]="config-files/tmux-temp $HOME/.config"

	for directory in "${directories[@]}"; do
		cp -r $directory && echo -e "${GREEN}$directory${END} Copied" || echo -e "${RED}LinuxSucks${END}....."
	done

	[ ! -f "$HOME/.tmux.conf" ] && cp -ar config-files/configs/tmux.conf $HOME/.tmux.conf && echo -e "${GREEN}tmux.conf${END} Capied" || echo -e "${RED}LinuxSucks${END}....."
}

edit-files() {
	echo -e "${BLUE}Edit tmux.conf file${END}"
	echo ""
	sleep 1

	while true; do
		read -p "Edit in home .tmux.conf [y - n] : " yn
		case $yn in
			[Yy]* )
				[ -f "$HOME/.tmux.conf" ] && vim $HOME/.tmux.conf || echo -e "${RED}LinuxSucks${END}....." ; break;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo ""

	while true; do
		read -p "Edit config-files tmux.conf [y - n] : " yn
		case $yn in
			[Yy]* )
				[ -f "config-files/configs/tmux.conf" ] && vim config-files/configs/tmux.conf || echo -e "${RED}LinuxSucks${END}....." ; break;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

keybindings() {
	less config-files/keybindings
}

press_enter() {
	echo ""
	echo -n "Press Enter To Continue"
	read
	clear
}

incorrect_selection() {
	echo -e "${RED}Incorrect selection! try again${END}"
}

until [ "$selection" = "0" ]; do
	clear
	echo -e "${BLUE}DarknessCode${END}"
	echo " _                         "
	echo "| |                        "
	echo "| |_ _ __ ___  _   ___  __ "
	echo "| __| '_ ' _ \| | | \ \/ / "
	echo "| |_| | | | | | |_| |>  <  "
	echo " \__|_| |_| |_|\__,_/_/\_\ "
	echo -e "${GREEN}A terminal multiplexer${END}"
	echo ""
	echo -e "Welcome: ${RED}$_user${END}"
	echo ""
	echo -e "${YELLOW}Installation${END}"
	echo "-------------------------------"
	echo -e "${GREEN}[1]${END} - Install tmux"
	echo -e "${GREEN}[2]${END} - Un-Install tmux"
	echo ""
	echo -e "${YELLOW}Edit & Custom files${END}"
	echo "-------------------------------"
	echo -e "${GREEN}[3]${END} - Edit tmux.conf file"
	echo -e "${GREEN}[4]${END} - Copy (custom) files"
	echo -e "${GREEN}[5]${END} - Keybindings"
	echo ""
	echo -e "${GREEN}[0]${END} - Exit"
	echo ""
	echo -n "Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install-tmux  ; press_enter ;;
		2) clear; uninstall-tmux  ; press_enter ;;
		3) clear; edit-files  ; press_enter ;;
		4) clear; config-files  ; press_enter ;;
		5) clear; keybindings  ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
