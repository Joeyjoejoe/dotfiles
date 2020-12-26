#!/usr/bin/bash
path="$(pwd)"
confFiles="$(find $(pwd)/etc -maxdepth 1 -mindepth 1 -type f -o -type d)"

for conf in $confFiles
do
  filename=$(basename "$conf")
  ln -s $conf ~/$filename
done

echo "All conf files deployed in ~/"
