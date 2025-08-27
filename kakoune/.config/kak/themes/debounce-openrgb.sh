#!/bin/sh
# Debounce OpenRGB runs so only the most recent trigger within DELAY fires.

LOCK="/tmp/openrgb-debounce.token"
DELAY=0.005   # 5ms; consider 0.02–0.05 if your system scheduler is jittery

THEME=$1
[ -n "$THEME" ] || { echo "Usage: $0 <theme>"; exit 1; }

# Make children ignore SIGHUP so we can be called without nohup if desired
trap '' HUP 2>/dev/null || true

# Create a unique token for THIS call and store token+theme atomically
TOKEN="$(date +%s%N).$$"
# two lines: 1st=token, 2nd=theme
printf '%s\n%s\n' "$TOKEN" "$THEME" > "$LOCK"

(
  mytoken="$TOKEN"
  sleep "$DELAY"

  # If the lock still contains our token, we're the most recent call
  read -r token < "$LOCK" || exit 0
  [ "$token" = "$mytoken" ] || exit 0

  # read theme from second line (paired with the token)
  theme="$(sed -n '2p' "$LOCK")"

  # send message to the RGBK daemon
  echo "$theme" | socat - UNIX-CONNECT:/tmp/rgbk.sock

  ## fire-and-forget OpenRGB; detached from terminal/session
  #nohup ~/.config/kak/themes/rgbk "$theme" >/dev/null 2>&1 &
  
) >/dev/null 2>&1 &

