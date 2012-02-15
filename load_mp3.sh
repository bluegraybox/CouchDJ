#!/bin/bash

base_url='http://colin:colinfuton@192.168.1.2:5984/couchdj'
read file
while test -n "$file" ; do
    path=${file%.mp3}
    path=${path//_/ }
    artist=${path%%/*}
    rest=${path#*/}
    album=${rest%%/*}
    track=${rest#*/}
    json='{ "type" : "track", "artist" : "'$artist'", "album" : "'$album'", "track" : "'$track'" }'
    path=${path,,}
    path=${path//[^A-Za-z0-9]/-}
    echo "Loading $path"
    rev=$(curl -s $base_url/$path | sed 's/.*"_rev":"\([^"]*\)".*/\1/;')
    if test -n "$rev" ; then
        echo "Deleting old document"
        curl -X DELETE $base_url/$path?rev=$rev
    fi
    echo "Creating document: '$json'"
    curl -X PUT -H 'content-type: application/json' --data "$json" $base_url/$path
    rev=$(curl -s $base_url/$path | sed 's/.*"_rev":"\([^"]*\)".*/\1/;')
    echo "Loading attachment: '$file'"
    curl -X PUT -H 'content-type: audio/mpeg' --data-binary @"$file" $base_url/$path/mp3?rev=$rev
    read file
done

