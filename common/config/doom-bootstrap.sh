#!/bin/sh
DOOM="$HOME/.emacs.d"
DOOM_LOCAL="$HOME/.doom.d"
DOOM_REPO_URL="https://github.com/doomemacs/doomemacs"
DOOM_CFG_REPO_URL="https://github.com/thonyprice/doom-emacs-private"

if [ ! -d "$DOOM" ]; then
  git clone --depth=1 --single-branch "${DOOM_REPO_URL}" "${DOOM}"
  git clone "${DOOM_CFG_REPO_URL}" "$DOOM_LOCAL"
	$DOOM/bin/doom -y install
fi

$DOOM/bin/doom sync
