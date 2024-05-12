#!/bin/sh

default_lang=$1
mappings=$2

printf 'Default Language: %s\nMappings:\n%s\n' "$default_lang" "$mappings"

if [ -z "$mappings" ]; then
  sphinx-build -M html "src/$default_lang" "build" -D language="$default_lang"
  return
fi

IFS=$'\n'
for mapping in $mappings; do
  folder="${mapping%%:*}"
  lang="${mapping##*:}"

  echo
  echo "# Start building for $folder (lang: $lang) ..."
  echo

  [ "$lang" = "$default_lang" ] && build_dir="build" || build_dir="build/$folder"
  sphinx-build -M html "src/$folder" "$build_dir" -D language="$lang"
done
