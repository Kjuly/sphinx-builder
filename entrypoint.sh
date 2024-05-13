#!/bin/sh

default_lang=$1
mappings=$2

printf 'Default Language: %s\nMappings:\n%s\n' "$default_lang" "$mappings"

if [ -z "$mappings" ]; then
  sphinx-build -M html "src" "build" -D language="$default_lang"
  return
fi

config_base_file="src/_conf.py"

IFS=$'\n'
for mapping in $mappings; do
  region="${mapping%%:*}"
  lang="${mapping##*:}"

  # Input & output dirs.
  input_dir="src/$region"
  [ "$lang" = "$default_lang" ] && output_dir="build" || output_dir="build/$region"

  # Setup conf.py file.
  config_override_file="$input_dir/_conf.py"

  if [ -f "$config_base_file" ] && [ -f "$config_override_file" ]; then
    config_file="$input_dir/conf.py"
    printf "\n# Setup %s ...\n" "$config_file"
    cp -v "$config_base_file" "$config_file"
    cat "$config_override_file" >> "$config_file"
  fi

  printf "\n# Start building for %s (lang: %s) ...\n" "$region" "$lang"
  sphinx-build -M html "$input_dir" "$output_dir" -D language="$lang"

  if [ "$lang" = "$default_lang" ]; then
    continue
  fi
  # Migrate html outputs.
  cp_dest="build/html/$region"
  [ -d "$cp_dest" ] && rm -rf "$cp_dest"
  cp -rf "$output_dir/html" "$cp_dest"
done
