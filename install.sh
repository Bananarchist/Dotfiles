#!/bin/bash

source installation/zsh.sh
#source installation/vim.sh
#source installation/nvim.sh
#source installation/tmux.sh
#source installation/ghci.sh

#global config
OVERWRITE_CONFIGS=0
CONFIGURE_ALL_SERVICES=1

#functions
Help()
{
	echo "Configure a new system"
	echo
	echo "Usage: install.sh [-h]"
	echo "options:"
	echo "h				 Print this help information"
	echo
}





ConfigureAll()
{
	echo "Setting up zshrc"
	ConfigureZsh
#	echo "Setting up vim"
#	ConfigureVim
#	echo "Setting up nvim"
#	ConfigureNvim
#	echo "Setting up tmux"
#	ConfigureTmux
#	echo "Setting up ghci"
#	ConfigureGhci
}




while getopts ":h" option; do
	case $option in
		h)
			Help
			exit;;
		\?)
			echo "Invalid option: {$OPTARG}"
			Help
			exit;;
	esac
done

if [[ $CONFIGURE_ALL_SERVICES -eq 1 ]]; then
	ConfigureAll
fi


