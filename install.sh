#!/bin/bash

# gitup -- Script that checks if a file .<name> exists in $HOME (for
#          every file and dir in the current working directory) and
#          copies it into the current directory. Intended to be used
#          as a helper while keeping dotfiles in git. Based on the
#          idea and implementation by Uli (psychon) Schlachter.
# Copyright (C) 2009 Adrian C. <anrxc_sysphere_org>
#           Licensed under the WTFPL


update () {
    file="$@"
    base_file=~/.$file

    # Fallback: no leading dot
    if [ ! -e "$base_file" ]; then
        base_file=~/$file
    fi

    if [ -f "$base_file" ]; then
        if diff "$base_file" "$file" > /dev/null; then
            # File did not change
            #echo "Skipped $file"
            return
        else
            # Normal files are just copied
        echo "Updating $file" >& 2
        cp -R "$base_file" "$file"
        return
    fi
    fi

    if [ -d "$base_file" ]; then
        # Dirs are handled recursively
        #echo "Recursively updating $file..."
    dirupdate $file/
    return
    fi

    echo "Skipping $file (unknown type)"
}


dirupdate () {
    for file in ${@}*; do
    case $file in
        gitup)
        continue
        ;;
    esac

    update "$file"
    done
}


dirupdate
cp -r vim ~/.vim