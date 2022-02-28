#!/bin/bash

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

#config zsh
ConfigureZsh()
{
	if [[ -e ~/.zshrc ]]; then
		echo "Found existing zshrc"
		if [[ -w ~/.zshrc ]]; then
			mv ~/.zshrc ~/.zshrc.orig
			cp zshrc ~/.zshrc
			echo "source ~/.zshrc.orig" >> ~/.zshrc
		else 
			echo "Skipping zshrc setup: ~/.zshrc not writable"
		fi
	fi
}


#config vim
ConfigureVim()
{
	if [[ -w ~/.vim/ ]]; then
		if [[ -e ~/.vim/vimrc ]]; then
			echo "Backing up existing vimrc"
			mv ~/.vim/vimrc ~/.vim/vimrc.backup
		fi
		if [[ -e ~/.vim/coc-settings.json ]]; then
			echo "Backing up existing coc-settings.json"
			mv ~/.vim/coc-settings.json ~/.vim/coc-settings.json.backup
		fi
		cp vim/vimrc ~/.vim/
		cp vim/coc-settings.json ~/.vim/coc-settings.json
	else
		echo "Skipping vim setup: ~/.vim not writable"
	fi
}


#config nvim
ConfigureNvim()
{
	if $(hash nvim 2>/dev/null); then
		if [[ -w ~/.config/nvim/ ]]; then
			if [[ -e ~/.config/nvim/init.lua ]]; then
				echo "Backing up existing init.lua"
				mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.backup
			elif [[ -e ~/.config/nvim/init.vim ]]; then
				echo "Backing up existing init.vim"
				mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
			fi
			cp config/nvim/init.lua ~/.config/nvim/
		else
			echo "Skipping nvim setup: ~/.config/nvim not writable"
		fi
	else
		echo "Skipping nvim setup: nvim not found"
	fi
}

#config tmux
ConfigureTmux()
{
	if $(hash tmux 2>/dev/null); then
		if [[ -e ~/.tmux.conf ]]; then
			echo "Backing up tmux"
			mv ~/.tmux.conf ~/.tmux.conf.backup
		fi
		cp tmux.conf ~/.tmux.conf
	else
		echo "Skipping tmux setup: tmux not found"
	fi
}


#config ghci
ConfigureGhci()
{
	if $(hash ghci 2>/dev/null); then
		if [[ -w ~/.ghc ]]; then
			if [[ -e ~/.ghc/ghci.conf ]]; then
				echo "Backing up ghci"
				mv ~/.ghc/ghci.conf ~/.ghc/.ghci.conf.backup
			fi
			cp tmux.conf ~/.tmux.conf
		else
			echo "Skipping ghci setup: ~/.ghc not writable"
		fi
	else
		echo "Skipping tmux setup: tmux not found"
	fi
}

ConfigureAll()
{
	echo "Setting up zshrc"
	ConfigureZsh
	echo "Setting up vim"
	ConfigureVim
	echo "Setting up nvim"
	ConfigureNvim
	echo "Setting up tmux"
	ConfigureTmux
	echo "Setting up ghci"
	ConfigureGhci
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


