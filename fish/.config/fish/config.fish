# ╭────────────────────────────────────────────────────────╮╭─╮
# │  ███████╗ ██████╗ ██╗       @solmateus ©2022-2024      ││&│
# │  ██╔════╝██╔═══██╗██║       <solmateusbraga@gmail.com> │╰─╯
# │  ███████╗██║   ██║██║                                  │
# │  ╚════██║██║   ██║██║       FISH                       │
# │  ███████║╚██████╔╝███████╗  fish                       │
# │  ╚══════╝ ╚═════╝ ╚══════╝                             │
# ╰────────────────────────────────────────────────────────╯
 
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"

set -gx EDITOR kak
set -g fish_greeting

alias hx helix
alias clear 'echo ">>> use <ctrl-l>"'
alias ask tgpt

set --erase --global FZF_DEFAULT_OPTS

set -Ux FZF_DEFAULT_OPTS "\
--color=fg:#c4c7c5,fg+:#fefefe,bg:#0F1014,bg+:#1c1e20 \
--color=hl:#faa821,hl+:#de6400,info:#2c2e30,marker:#3870ed \
--color=prompt:#cb333a,spinner:#cb333a,pointer:#3870ed,header:#188743 \
--color=border:#1c1e20,separator:#1c1e20,label:#aeaeae,query:#c4c7c5 \
--border='rounded' --border-label='' --preview-window='border-rounded' --prompt='> ' \
--marker='>' --pointer='◆' --separator='─' --scrollbar='│'
"

# better compilation times
export RUSTC_WRAPPER=sccache
