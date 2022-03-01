#!/bin/zsh


Success()
{
	echo -e "\e[32mSuccess\e[0m"
}

Failure()
{
	echo -e "\e[31mFailed\e[0m"
}


#test zsh configure function
echo "ZSH Test"
source installation/zsh.test.sh
if [[ TestZsh -eq 1 ]]; then
	Failure
	exit 1
else
	Success
fi
