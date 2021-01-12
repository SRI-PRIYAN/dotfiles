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
alias refresh="source ~/.bashrc";

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
                if [[ ${dependancies[*]} =~ ${dep_file} ]]; then
                    continue;
                fi
                local dependancies[$i]=$dep_file;
                (( i++ ));
            fi
        
        done
        $compiler -O2 ${dependancies[@]} $file -o ${executable};
    done
}

# creates a dir for the specified codeforces contests and each of which containing subdir for each problem
# in that contest which in turn contains the sample testcases, output files for the same and the template
# file if cp_outline.cpp exists in the home directory.
# syntax : codeforces <contest_id1> <contest_id2> and so on
function codeforces() {
    if [[ $# -eq 0 ]]; then
        echo "Contest ID required!";
        return;
    fi

    for contest_id in $@; do
        python3 ~/webscraper.py . ${contest_id};
    done
}

# A utility function which does all the hard work for the grade function.
function util_grade() {
    local success="true";
    for src in $@; do
        echo -e "\n----------Grading ${src}----------\n";
        echo -e "\ncompiling ${src}...\n";

        compile ${src};
        if [[ $? -ne 0 ]]; then
            success="false";
            continue;
        fi
        
        local test_cases_failed=0;

        local executable=${src%.*};
        for input in $(ls input*.txt); do
            echo "------------------------";
            echo "Running on ${input} : ";
            ./${executable} < ${input} > ~/.dumpfile;
            cat ~/.dumpfile;
            local output="output"${input#input};
            echo -e "\nEcpected (${output}) : ";
            cat $output;
            echo "------------------------";
            diff -w ~/.dumpfile ${output} > /dev/null;
            if [[ $? -eq 0 ]]; then
                echo "${green}${input} : Ok ${reset}";
            else
                echo "${red}${input} : Failed ${reset}";
                (( test_cases_failed++ ))
            fi
        done

        echo "------------------------";
        if [[ ${test_cases_failed} -eq 0 ]]; then
            echo -e "\n${green}All TestCases Passed! ${reset}";
        else
            echo -e "\n${red}${test_cases_failed} TestCase(s) failed";
        fi

    done

    if [[ success == "true" ]];then
        return 0;
    else
        return 1;
    fi
}


# Takes in a 'c' or 'cpp' file as argument.
# compiles it and runs it against all the input<number>.txt files
# and checks the output against the corresponding output<number>.txt files
# and displays the output in less mode so that the user need not scroll up
# to see the output from the top.
function grade() {
    if [[ $# -eq 0 ]]; then
        echo "source file to be tested required!";
        return;
    fi
    
    echo "Running on Testcases...";
    util_grade $@ > ~/.outfile;
    less -R ~/.outfile;
}

# Creates classes for C++ files (Both header as well as cpp files)
function class() {
    if [[ $# -eq 0 ]]; then
        echo "Class Name Required";
        return;
    fi

    for class_name in $@; do
        local header="${class_name}.h";
        local source="${class_name}.cpp";

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


# Function to give outline to C and C++ files
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
        
        if [[ $flag == "-cp" ]]; then
            local source="cp_outline."${extension};
        else
            local source="outline."${extension};
        fi

        if [[ ! -e ~/${source} ]]; then
            echo "Create a ${source} file in the Home Directory for creating ${file}";
            continue;
        fi

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
            elif [ $flag != "-cp" ]; then
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
