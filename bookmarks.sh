#############################################
# Bookmarks                                 #
#                                           #
# For easy access to often-used directories #
#############################################

bookmark_file=~/.bookmarks
source "$bookmark_file"

bm() {
usage='Usage:
bm add <name> <path>           Create a bookmark for path.
bm add <name>                  Create a bookmark for the current directory.
bm edit <name> <new path>      Edit a bookmark to point to a new path.
bm edit <name>                 Edit a bookmark to point to the current directory.
bm update                      Source the bookmark file.
bm remove <name>               Remove a bookmark.
bm list                        List all bookmarks.
bm ls                          Alias for list.'              

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
            echo "bm: The name $2 is in use."
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
    update)
        if [[ $# -eq 1 ]]; then
            source "$bookmark_file"
            return 0
        fi
        ;;
    remove)
        if [[ $# -eq 2 ]]; then
            unset $2
            local contents=$(grep -v "^${2}=" "$bookmark_file")
            echo "$contents" > "${bookmark_file}.tmp"
            rm -f "$bookmark_file"
            mv "${bookmark_file}.tmp" "$bookmark_file"
            return 0
        fi
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
    list | ls)
        cat "$bookmark_file"
        return 0
        ;;
esac

echo "$usage"
return 1
}
