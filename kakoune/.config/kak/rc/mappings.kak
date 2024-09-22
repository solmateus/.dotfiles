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

# > SELSUR MODE
# : m   -> selsur mode
# : ma  -> select surrounding object
# : mi  -> select surrounding inner object
# : ms  -> surround
# : mc  -> change surround
# : md  -> delete surround
# : mt  -> select tag
# : mtt -> select surrounding tag
# : mtc -> change surrounding tag
# : mta -> select surrounfing tag
# : mm  -> kakoune 'm', selects closest brackets
# : mM  -> kakoune 'M', expands selection to next bracket 

map global normal = m
map global normal + M

def enter-sel-sur-obj     %{ exec "<a-a>" }
def enter-sel-sur-inn-obj %{ exec "<a-i>" }

declare-user-mode selsur
map global normal m -docstring "Select Surround Mode"      \
  ":enter-user-mode selsur<ret>"

map global selsur m -docstring "select closest brackets"   \
  ":exec m<ret>"
map global selsur a -docstring "select surr. obj..."       \
  ":enter-sel-sur-obj<ret>"
  
map global selsur i -docstring "select surr. inner obj..." \
  ":enter-sel-sur-inn-obj<ret>"

map global selsur s -docstring "surr. selection..."        \
  ":surround<ret>"
  
map global selsur c -docstring "change surround..."        \
  ":change-surround<ret>"

map global selsur d -docstring "delete surround..."        \
  ":delete-surround<ret>"

map global selsur d -docstring "delete surround..."        \
  ":delete-surround<ret>"

declare-user-mode selsur-tag
map global selsur t -docstring "tag..."                    \
  ":enter-user-mode selsur-tag<ret>"

map global selsur-tag t -docstring "select surr. tag..."   \
  ":select-surrounding-tag<ret>"

map global selsur-tag c -docstring "change surr. tag..."   \
  ":change-surrounding-tag<ret>"

map global selsur-tag d -docstring "delete surr. tag..."   \
  ":delete-surrounding-tag<ret>"
