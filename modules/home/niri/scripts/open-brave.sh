#!/bin/sh

# Get the name of the active workspace
active_name="$(
  niri msg --json workspaces \
  | jq -r '.[] | select(.is_active) | .name // empty'
)"

case "$active_name" in
  "Oxf")
    niri msg action spawn -- brave --profile-directory="Default"
    ;;
  "Prj")
    niri msg action spawn -- brave --profile-directory="Profile 3"
    ;;
  "Fun")
    niri msg action spawn -- brave --profile-directory="Profile 2"
    ;;
  *)
    niri msg action spawn -- brave
    ;;
esac

