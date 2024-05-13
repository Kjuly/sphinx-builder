#!/bin/sh

SOURCE_ROOT=$1
BUILD_ROOT=$2
default_lang=$3
mappings=$4

printf 'Default Language: %s\nMappings:\n%s\n' "$default_lang" "$mappings"

if [ -z "$mappings" ]; then
  sphinx-build -M html "$SOURCE_ROOT" "$BUILD_ROOT" -D language="$default_lang"
  return
fi

config_base_file="$SOURCE_ROOT/_conf.py"

IFS="$(printf '\n\b')"
for mapping in $mappings; do
  region="${mapping%%:*}"
  lang="${mapping##*:}"

  # Input & output dirs.
  input_dir="$SOURCE_ROOT/$region"
  [ "$lang" = "$default_lang" ] && output_dir="$BUILD_ROOT" || output_dir="$BUILD_ROOT/$region"

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
  cp_dest="$BUILD_ROOT/html/$region"
  [ -d "$cp_dest" ] && rm -rf "$cp_dest"
  cp -rf "$output_dir/html" "$cp_dest"
done
