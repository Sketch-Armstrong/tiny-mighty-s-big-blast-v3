#!/bin/sh
echo -ne '\033c\033]0;Tiny Mighty's Big Blast 1 point 2\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Tiny Mighty's Big Blast 1 point 2 testing Export.x86_64" "$@"
