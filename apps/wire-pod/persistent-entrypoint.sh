#!/usr/bin/env bash
set -euo pipefail

persist=/wire-pod/data
mkdir -p "$persist"

link_file() {
  local source=$1 destination=$2
  mkdir -p "$(dirname "$destination")"
  if [[ ! -e "$destination" ]]; then
    if [[ -e "$source" ]]; then
      cp -a "$source" "$destination"
    else
      : > "$destination"
    fi
  fi
  rm -f "$source"
  ln -s "$destination" "$source"
}

link_dir() {
  local source=$1 destination=$2
  mkdir -p "$destination"
  if [[ -d "$source" ]] && [[ -z "$(find "$destination" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
    cp -a "$source"/. "$destination"/
  fi
  rm -rf "$source"
  ln -s "$destination" "$source"
}

link_file /wire-pod/chipper/apiConfig.json "$persist/apiConfig.json"
link_file /wire-pod/chipper/customIntents.json "$persist/customIntents.json"
link_file /wire-pod/chipper/botConfig.json "$persist/botConfig.json"
link_dir /wire-pod/chipper/jdocs "$persist/jdocs"
link_dir /wire-pod/chipper/session-certs "$persist/session-certs"
link_dir /wire-pod/chipper/plugins "$persist/plugins"
link_dir /wire-pod/certs "$persist/certs"
link_dir /tmp/.anki_vector "$persist/anki_vector"

cd /wire-pod/chipper
source ./source.sh
exec ./chipper
