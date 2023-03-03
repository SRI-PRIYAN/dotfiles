eval "$(/opt/homebrew/bin/brew shellenv)"

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	black=$(tput setaf 0);
	blue=$(tput setaf 153);
	cyan=$(tput setaf 37);
	green=$(tput setaf 46);
	orange=$(tput setaf 202);
	purple=$(tput setaf 125);
	red=$(tput setaf 196);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	bright_yellow=$(tput setaf 226);
	yellow=$(tput setaf 228);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;