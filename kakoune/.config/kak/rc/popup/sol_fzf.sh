#!/bin/bash
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#c4c7c5,fg+:#fefefe,bg:#0F1014,bg+:#1c1e20
  --color=hl:#faa821,hl+:#de6400,info:#2c2e30,marker:#3870ed
  --color=prompt:#cb333a,spinner:#cb333a,pointer:#3870ed,header:#188743
  --color=border:#1c1e20,separator:#1c1e20,label:#aeaeae,query:#c4c7c5
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

fzf --border=top --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window 70% --bind 'ctrl-/:change-preview-window(50%|hidden|)'
