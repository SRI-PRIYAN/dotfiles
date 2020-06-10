# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#aliases
alias winhome="cd /mnt/c/users/ELCOT";
alias edu="cd /mnt/d";
alias 'ls-detail'="ls -C -c -lt --color -s --size";
alias reload-bash="source ~/.bash_profile";

# Function to compile C and C++ easily
function compile() {

	for file in $@; do      #looping through all the files passed in as arguments
		local extension=${file#*.};     #storing the extension and executable of the file
		local executable=${file%.*};
		case $extension in
			c)
				gcc -o $executable $file;
				;;
			cpp)
				g++ -o $executable $file;
				;;
			*)
				echo "INVALID EXTENSION";
				;;
		esac
	done

}

# compiles all the dependancies (i.e., all the c and cpp files associated with the local header files included)
function comdep() {
    regex="^\"(.*)\"$";
    for file in $@; do
        local extension=${file#*.};
        
        if [[ $extension == "c" ]]; then
            local compiler="gcc";
        elif [[ $extension == "cpp" ]]; then
            local compiler="g++";
        else
            echo "Invalid File";
            return;
        fi
        
        local executable=${file%.*};
        local i=0;
        local temp=( $(grep "#include \"*\"" $file | cut -f2 -d " ") );
        for line in ${temp[@]}; do
            [[ $line =~ $regex ]] && headers=${BASH_REMATCH[1]};
            
            if [[ ${headers#*.} == "h" ]]; then
                local dep_file=${headers%.*}"."${extension};
                local temp="^${dep_file}$"
                if [[ ${dependancies[*]} =~ ${dep_file} ]]; then
                    continue;
                fi
                local dependancies[$i]=$dep_file;
                (( i++ ));
            fi
        
        done
        $compiler -O3 ${dependancies[@]} $file -o ${executable};
    done
}

# Creates classes for C++ files (Both header as well as cpp files)
function class() {
    if [[ $# -eq 0 ]]; then
        echo "Class Name Required";
        return;
    fi

    for class_name in $@; do
        local header="${class_name}.h"
        local source="${class_name}.cpp"

        if [[ -e $header || -e $source ]]; then
            read -p "$header or $source already exists. Do You wanna replace them? [Y/N]" permisson;
        fi

        if [[ $permisson == "n" || $permisson == "N" ]]; then
            unset permisson;
            continue;
        fi

        cp ~/class.h $header;
        cp ~/class.cpp $source;

        sed -i "s/x/${class_name}/g" $header;
        sed -i "s/x/${class_name}/g" $source;

    
    done


}

# My function to run C and C++ executable files easily
function run() {
	
    for file in $@; do
		local executable=${file%.*};
		if  [ -e $executable ]; then    #checking if the file was already compiled
			echo -e "\n----- Running : ${file} -----\n";
			./$executable;
		else    # if it's not compiled already, the compile it and then run the executable
			echo -e "\n----- Running : ${file} -----\n";
			compile $file;      # compile function is declared above
			./$executable;
		fi
	done

}


# My function to give outline to C and C++ files
# SYNTAX : out [-v or -c] [C or CPP file]
# The order of the arguments doesn't matter and [-v or -c] is optional
# -v stands for open the created file in vim editor
# -c stands for open the created file in vscode (If it is installed)
# You can provide any number of files

function out() {
    
    if [ $# -eq 0 ]; then
        echo "Too Few Arguments";
        return;
    fi

    local i=0;

    for temp in $@; do
        case $temp in
            -*)
                local flag=$temp;
                ;;
            *.c)
                local files[$i]=$temp;
                (( i++ ));
                ;;
            *.cpp)
                local files[$i]=$temp;
                (( i++ ));
                ;;
            *.py)
                local files[$i]=$temp;
                (( i++ ));
                ;;
            *.java)
                local files[$i]=$temp;
                (( i++ ));
                ;;
            *)
                echo "Invalid Argument";
                return;
                ;;
        esac
    done

    if [ ${#files[@]} -eq 0 ]; then
        echo "File Name Required";
        return;
    fi

    for file in ${files[@]}; do
        local class=${file%.*};     #Only for java files
        local extension=${file#*.};
        local source="outline."$extension;
        if [ -e $file ]; then
            echo "$file Already exists";
            read -p "Do You Wanna replace its contents?[Y/N] : " permission;

            if [ $permission == n -o $permission == N ]; then
                continue;
            fi
        fi
        touch $file;

        # For java files we need to change the class name
        if [ $extension == "java" ]; then
            sed -i "s/class .*/class ${class} {/" ~/$source;
        fi


        cp ~/$source $file;

        if [ ! -z ${flag+x} ]; then
            if [ $flag == "-v" ]; then
                vim $file;
            elif [ $flag == "-c" ]; then
                code -r $file;
            else
                echo "Invalid Flag";
            fi
        fi
    done

}
#Function to create Directory and enter the directory
#Combining mkdir+cd commands
#Inspired from Missing Semester classes MIT
#SYNTAX: mcd dir_name
function mcd(){
        if [ $# -eq 0 ]; then
                echo "Too few arguments";
                return;
        fi
        #declare -a list;
        #readarray list < <(find -name "$1" -type d);
        if [ -d $1 ];then
                echo "Directory name already exists";
                read -p "Do you want to Open the existing directory[Y/N] ?:" ans;
                if [ $ans == "Y" -o $ans == "y" ]; then
                        cd "$1";
                        return;
                fi
                if [ $ans ==  "N" -o $ans == "n" ]; then
                        return;
                fi
        fi
        mkdir "$1";
        echo "Directory created";
        cd "$1";
}
#Function to access tldr help pages
#Just to make tldr command more self-explanative and intuitive
#
function Help(){
         if [ $# -eq 0 ]; then
                echo "Too few arguments";
                return;
        fi
        if [ $# -gt 1 ]; then
                echo "Too many arguments";
                echo "Give one command at a time";
                return;
        fi
        echo -e "\n------------ "$1"--------------\n";
        tldr "$1";
}

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	# Ensure existing Homebrew v1 completions continue to work
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;
