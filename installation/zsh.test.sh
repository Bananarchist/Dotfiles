TestZsh()
{
	if [[ -e ~/.zshrc ]]; then
		mv ~/.zshrc ~/.zshrc.test.backup
		touch ~/.zshrc
		ConfigureZsh 1>/dev/null
		if [[ -e ~/.zshrc && -e ~/.zshrc.orig ]]; then
			rm ~/.zshrc
			rm ~/.zshrc.orig
			mv ~/.zshrc.test.backup ~/.zshrc
		else
			echo "Either ~/.zshrc or ~/.zshrc.orig does not exist"
			1
		fi
	else
		ConfigureZsh 1>/dev/null
		if [[ -e ~/.zshrc ]]; then
			rm ~/.zshrc
		else
			echo "~/.zshrc does not exist"
			1
		fi
	fi
}

