#!/bin/bash

set NVIM_INSTALLED=$(hash nvim 2>/dev/null)
set TMUX_INSTALLED=$(hash tmux 2>/dev/null)


#config zsh
echo "Setting up zshrc"
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


#config vim
echo "Setting up vim"
if [[ -w ~/.vim/ ]]; then
	echo "Setting up vim"
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


#config nvim
if $NVIM_INSTALLED; then
	echo "Setting up nvim"
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


#config tmux
if $TMUX_INSTALLED; then
	echo "Setting up tmux"
	if [[ -e ~/.tmux.conf ]]; then
		echo "Backing up tmux"
		mv ~/.tmux.conf ~/.tmux.conf.backup
	fi
	cp tmux.conf ~/.tmux.conf
else
	echo "Skipping tmux setup: tmux not found"
fi
