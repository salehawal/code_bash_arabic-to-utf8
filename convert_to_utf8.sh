#!/bin/bash
FROM_ENCODING="WINDOWS-1256"
TO_ENCODING="UTF-8"
file_encoding=''

# convert file
convert_file()
{
     echo "converting file: ${fname}"
     iconv -f $FROM_ENCODING -t $TO_ENCODING "$fname" > "${fname}.temp"
     rm "$fname"
     mv "${fname}.temp" "$fname"
}

# find non-utf files
find_and_convert()
{
     find . -type f -not -path '*/\.*' | while read fname
     do
          if { [[ "$fname" == *.php ]] || [[ "$fname" == *.htm ]] || [[ "$fname" == *.html ]]; }; then
               file_encoding="$(file --mime-encoding "$fname")"
               if { [[ "$file_encoding" != *"utf-8"* ]]; }; then
                    echo $file_encoding
                    convert_file
               fi;
          fi;
     done
     exit 0
}

# Start The Processs
find_and_convert
####################
