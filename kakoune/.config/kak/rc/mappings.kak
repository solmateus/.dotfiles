# ╭───────────────────────────────────────────────────────────╮
# │ @ Mappings : rc/mappings.kak                              │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Loads custom mappings.                                  ┆
# ┆ % For better integration with modules, a new system shou- ┆
# ┆   be implemented, where mappings are stored and remember- ┆
# ┆   ed.                                                     ┆
# ╰───────────────────────────────────────────────────────────╯

# ╭───────────────────────────────────────────────────────────╮
# │ > NORMAL                                                  │
# ╰───────────────────────────────────────────────────────────╯
# > 'y' copies selections to system clipboard through 'xsel'.
map global user 'y' '<a-|>sudo -u sol xsel --input --clipboard<ret>'

# > '<esc>' calls qol escape command
map global insert <esc> "<a-;>:escape<ret>"
map global normal <esc> "<a-;>:escape<ret>"

