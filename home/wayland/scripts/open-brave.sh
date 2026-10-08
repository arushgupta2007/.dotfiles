#!/usr/bin/env bash
#
# open-brave.sh: open Brave with a workspace-specific profile.
#
# The script mirrors the user's prior behaviour: pick the Brave profile
# based on the active Niri workspace name. Falls back to the default
# profile for unnamed workspaces.

set -eu

active_name="$(
  niri msg --json workspaces \
  | jq -r '.[] | select(.is_active) | .name // empty'
)"

case "$active_name" in
  "Oxf") niri msg action spawn -- brave --profile-directory="Default" ;;
  "Prj") niri msg action spawn -- brave --profile-directory="Profile 3" ;;
  "Fun") niri msg action spawn -- brave --profile-directory="Profile 2" ;;
  *)     niri msg action spawn -- brave ;;
esac
