#############################################
# Bookmarks                                 #
#                                           #
# For easy access to often-used directories #
#############################################

bookmark_file=~/.bookmarks
source "$bookmark_file"

bm() {
usage='Usage:
bm add <name> [path]           Create a bookmark pointing to path (current directory by default)
bm edit <name> [new path]      Edit a bookmark to point to a new path (current directory by default)
bm remove <name>               Remove a bookmark
   rm <name>
bm list                        List all bookmarks
   ls
bm echo <name>                 Print the path of a bookmark
bm go <name>                   Change current directory (cd) to a bookmark's path
bm update                      Source the bookmark file
bm help                        Print this usage info'

case $1 in
    add)
        local path
        if [[ $# -eq 2 ]]; then
            path=.
        elif [[ $# -eq 3 ]]; then
            if [[ -e $3 ]]; then
                path="$3"
            else
                echo "bm: ${3}: No such file or directory."
                return 1
            fi               
        else
            echo "$usage"
            return 1
        fi

        if declare | grep "^${2}=" > /dev/null; then
            echo "bm: $2: This name is already in use."
            return 1
        fi
        if hash greadlink 2>/dev/null; then
            path=$(greadlink -f "$path")
        else
            path=$(readlink -f "$path")
        fi
        echo ${2}=\""$path"\" >> "$bookmark_file"
        eval ${2}=\""$path"\"
        return 0
        ;;
    edit)
        local path
        if [[ $# -eq 2 ]]; then
            path=.
        elif [[ $# -eq 3 ]]; then
            if [[ -e $3 ]]; then
                path="$3"
            else
                echo "bm: ${3}: No such file or directory."
                return 1
            fi
        else
            echo "$usage"
            return 1
        fi
        
        bm remove "$2"
        bm add "$2" "$path"
        return 0
        ;;
    remove | rm)
        if [[ $# -eq 2 ]]; then
            unset $2
            if [[ $(grep "^${2}=" "$bookmark_file") ]]; then
                local contents=$(grep -v "^${2}=" "$bookmark_file")
                echo "$contents" > "${bookmark_file}.tmp"
                rm -f "$bookmark_file"
                mv "${bookmark_file}.tmp" "$bookmark_file"
                return 0
            else
                echo "bm: ${2}: No such bookmark."
                return 1
            fi
        fi
        ;;
    list | ls)
        if [[ $# -eq 1 ]]; then
            cat "$bookmark_file"
            return 0
        fi
        ;;
    echo)
        if [[ $# -eq 2 ]]; then
            local line=$(grep "^$2=" "$bookmark_file")
            if [[ $line ]]; then
                echo $line | cut -c"$(($(echo $2 | wc -c) + 2))"-"$(($(echo $line | wc -c) - 2))"
                return 0
            else
                echo "bm: $2: No such bookmark."
                return 1
            fi
        fi
        ;;
    go)
        if [[ $# -eq 2 ]]; then
            local line=$(grep "^$2=" "$bookmark_file")
            if [[ $line ]]; then
                cd $(echo $line | cut -c"$(($(echo $2 | wc -c) + 2))"-"$(($(echo $line | wc -c) - 2))")
                return 0
            else
                echo "bm: $2: No such bookmark."
                return 1
            fi
        fi
        ;;
    update)
        if [[ $# -eq 1 ]]; then
            source "$bookmark_file"
            return 0
        fi
        ;;
    help)
        if [[ $# -eq 1 ]]; then
            echo "$usage"
            return 1
        fi
        ;;
esac

echo "$usage"
return 1
}
