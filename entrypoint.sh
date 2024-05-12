#!/bin/sh

default_lang=$1
mappings=$2

printf 'Default Language: %s\nLanguages:\n%s\n' "$default_lang" "$mapping"

if [ -z "$mappings" ]; then
  make html
  return
fi

IFS=$'\n'
for mapping in $mappings; do
  folder="${mapping%%:*}"
  lang="${mapping##*:}"

  echo
  echo "# Start building for $folder (lang: $lang) ..."
  echo

  make -e \
    SPHINXOPTS="-D language='$lang'" \
    SOURCEDIR="./src/$folder" \
    BUILDDIR="./build/$folder" \
    html
done
