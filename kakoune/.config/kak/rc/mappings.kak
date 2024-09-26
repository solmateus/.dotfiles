# ╭───────────────────────────────────────────────────────────╮
# │ @ Mappings : rc/mappings.kak                              │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Loads custom mappings.                                  ┆
# ┆ % For better integration with modules, a new system shou- ┆
# ┆   be implemented, where mappings are stored and remember- ┆
# ┆   ed.                                                     ┆
# ╰───────────────────────────────────────────────────────────╯

# ╭───────────────────────────────────────────────────────────╮
# │ > Normal                                                  │
# ╰───────────────────────────────────────────────────────────╯
unmap global normal q
unmap global normal Q
map global normal q z
map global normal Q Z

# ╭───────────────────────────────────────────────────────────╮
# │ > Insert                                                  │
# ╰───────────────────────────────────────────────────────────╯

map -docstring "undo/redo"                       global insert <c-y> "<a-;>u"
map -docstring "undo/redo"                       global insert <a-y> "<a-;>U"
map -docstring "move cursor left/right"          global insert <c-f> "<esc>li"
map -docstring "move cursor left/right"          global insert <c-b> "<esc>hi"
map -docstring "move cursor back/forward a word" global insert <a-b> "<esc>b;i"
map -docstring "move cursor back/forward a word" global insert <a-f> "<esc>w;i"
map -docstring "backspace/del"                   global insert <c-h> "<backspace>"
map -docstring "backspace/del"                   global insert <c-d> "<del>"
map -docstring "delete to start/end of line"     global insert <c-u> "<esc>GHdi"
map -docstring "delete to start/end of line"     global insert <c-k> "<esc>GLdi"
map -docstring "delete word to the left/right"   global insert <c-w> "<esc>bdi"
map -docstring "delete word to the left/right"   global insert <a-d> "<esc>bdi"
map -docstring "go to previous/next jump"        global insert <c-o> "<a-;><c-o>"
map -docstring "go to previous/next jump"        global insert <c-i> "<a-;><c-i>"
map -docstring "write file"                      global insert <c-s> "<a-;>:w<ret>"
map -docstring "soft exit"                       global insert <c-q> "<a-;><c-o>"

# > to learn insert mode
declare-user-mode insert-learn
map global insert <c-l> "<a-;>:enter-user-mode insert-learn<ret>"
map -docstring "undo/redo"                       global insert-learn <c-y> ""
map -docstring "undo/redo"                       global insert-learn <a-y> ""
map -docstring "move cursor left/right"          global insert-learn <c-f> ""
map -docstring "move cursor left/right"          global insert-learn <c-b> ""
map -docstring "move cursor back/forward a word" global insert-learn <a-b> ""
map -docstring "move cursor back/forward a word" global insert-learn <a-f> ""
map -docstring "backspace/del"                   global insert-learn <c-h> ""
map -docstring "backspace/del"                   global insert-learn <c-d> ""
map -docstring "delete to start/end of line"     global insert-learn <c-u> ""
map -docstring "delete to start/end of line"     global insert-learn <c-k> ""
map -docstring "delete word to the left/right"   global insert-learn <c-w> ""
map -docstring "delete word to the left/right"   global insert-learn <a-d> ""
map -docstring "go to previous/next jump"        global insert-learn <c-o> ""
map -docstring "go to previous/next jump"        global insert-learn <c-i> ""
map -docstring "write file"                      global insert-learn <c-s> ""
map -docstring "soft exit"                       global insert-learn <c-q> ""

# ╭───────────────────────────────────────────────────────────╮
# │ > Goto                                                    │
# ╰───────────────────────────────────────────────────────────╯
define-command buffer-next-pretty %{
  buffer-next
  echo -markup "{rgb:%opt{SolNormalAccent},rgb:%opt{SolStatusLineBackground}}  >>> %val{bufname}"
}

define-command buffer-previous-pretty %{
  buffer-next
  echo -markup "{rgb:%opt{SolNormalAccent},rgb:%opt{SolStatusLineBackground}}  <<< %val{bufname}"
}

map -docstring "next/previous buffer" global goto n \
  "<esc>:buffer-next-pretty<ret>"     
map -docstring "next/previous buffer" global goto p \
  "<esc>:buffer-previous-pretty<ret>" 

# ╭───────────────────────────────────────────────────────────╮
# │ > User                                                    │
# ╰───────────────────────────────────────────────────────────╯
map -docstring "write/quit current buffer"        global user 'w' \
  ":write<ret>"
map -docstring "write/quit current buffer"        global user 'q' \
  ":write-quit<ret>"
map -docstring "buffers..."                       global user 'b' \
  ':b '
map -docstring "force delete current/all buffers" global user 'd' \
  ":delete-buffer<ret>"
map -docstring "force delete current/all buffers" global user 'D' \
  ":delete-buffer!<ret>"
map -docstring "format buffer"                    global user 'f' \
  ":try %{lsp-formatting-sync}<ret>"
map -docstring "yank/paste with system clipboard" global user 'y' \
  '<a-|> xsel --input --clipboard <ret>'
map -docstring "yank/paste with system clipboard" global user 'p' \
  '<a-!> xsel --output --clipboard <ret>'
map -docstring "open kakrc"                       global user '1' \
  ":e ~/.config/kak/kakrc<ret>"

# ╭───────────────────────────────────────────────────────────╮
# │ > Buffer                                                  │
# ╰───────────────────────────────────────────────────────────╯
declare-user-mode buffer
map -docstring "buffer..."           global user   b \
  ":enter-user-mode buffer<ret>"

map -docstring "delete buffer"       global buffer d \
  ":db<ret>" 
map -docstring "force delete buffer" global buffer D \
  ":db!<ret>"

# ╭───────────────────────────────────────────────────────────╮
# │ > LSP                                                     │
# ╰───────────────────────────────────────────────────────────╯
map -docstring "open lsp"                        global normal z     \
  ":enter-user-mode lsp<ret>" 
map -docstring 'Select next snippet placeholder' global insert <tab> \
  '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' 
map -docstring "LSP any symbol"                  global object a     \
  "<a-;>lsp-object<ret>" 
map -docstring "LSP any symbol"                  global object <a-a> \
  "<a-;>lsp-object<ret>" 
map -docstring "LSP function or method"          global object f     \
  "<a-;>lsp-object Function Method<ret>" 
map -docstring "LSP class interface or struct"   global object t     \
  "<a-;>lsp-object Class Interface Struct<ret>" 
map -docstring "LSP errors and warnings"         global object d     \
  "<a-;>lsp-diagnostic-object --include-warnings<ret>" 
map -docstring "LSP errors"                      global object D     \
  "<a-;>lsp-diagnostic-object<ret>" 

# ╭───────────────────────────────────────────────────────────╮
# │ > NORMAL                                                  │
# ╰───────────────────────────────────────────────────────────╯
# > 'y' copies selections to system clipboard through 'xsel'.
map global user 'y' '<a-|>sudo -u sol xsel --input --clipboard<ret>'

# > '<esc>' calls qol escape command
map global insert <esc> "<a-;>:escape<ret>"
map global normal <esc> "<a-;>:escape<ret>"

# ╭───────────────────────────────────────────────────────────╮
# │ > Selsur : Selection and Surrounding                      │
# ╰───────────────────────────────────────────────────────────╯
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
map global normal m -docstring "Select Surround Mode"                        \
  ":enter-user-mode selsur<ret>"

map global selsur m -docstring "select contents of closest pair [inclusive]" \
  ":exec m<ret>"
  
map global selsur a -docstring "select surr. obj..."                         \
  ":enter-sel-sur-obj<ret>"
  
map global selsur i -docstring "select surr. inner obj..."                   \
  ":enter-sel-sur-inn-obj<ret>"

map global selsur s -docstring "surr. selection..."                          \
  ":surround<ret>"
  
map global selsur c -docstring "change surr. of selection..."                \
  ":change-surround<ret>"

map global selsur d -docstring "delete surr. of selection..."                \
  ":delete-surround<ret>"

declare-user-mode selsur-tag
map global selsur t -docstring "tag..."                                      \
  ":enter-user-mode selsur-tag<ret>"

map global selsur-tag t -docstring "select surr. tag..."                     \
  ":select-surrounding-tag<ret>"

map global selsur-tag c -docstring "change surr. tag..."                     \
  ":change-surrounding-tag<ret>"

map global selsur-tag d -docstring "delete surr. tag..."                     \
  ":delete-surrounding-tag<ret>"
