# ╭───────────────────────────────────────────────────────────╮
# │ @ QOL : rc/qol.kak                                        │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Kakoune quality of life improvements.                   ┆
# ╰───────────────────────────────────────────────────────────╯

# > options
#   : set tab width
perl %{ if ($ARGV[0] ne "") {
  kak "set global tabstop $ARGV[0]";
  kak "set global indentwidth $ARGV[0]";
}} %opt{sol_tab_width}

#   : scroll distance

perl %{ if ($ARGV[0] ne "false") {
  kak "set global scrolloff 6,12"
}} %opt{sol_better_scrolloff}

#   : removes kakoune greeting message
perl %{ if ($ARGV[0] ne "false") {
  kak "set -remove global startup_info_version 20240518"
}} %opt{sol_disable_greeting}

#   : disables clippy
perl %{ if ($ARGV[0] ne "false") {
  kak "set global ui_options terminal_assistant=none"
}} %opt{sol_disable_clippy}

# > commands
#   : reload
def reload %{
    colorscheme "%opt{theme}"
    # % TODO: update rulers (if rulers module is active)
    # % TODO: apply default colors (if a sol theme is active)
}

#   : escape
def escape %{
    exec "<esc>,;"
    try %{ reload }
}

#   : write-delete-buffer
def write-delete-buffer %{
  try %{
    write
    delete-buffer!
  }
}

# > hooks
#   : [sol_escape_alias, default 'jk'] leaves insert mode
hook global InsertChar "[%opt{sol_escape_alias}]" %{
  try %{
    exec -draft "hH<a-k>jk<ret>d"
    escape
  }
}

#   : tab and s-tab to use completions
hook global InsertCompletionShow .* %{
    try %{
        execute-keys -draft 'h<a-K>\h<ret>'
        map window insert <tab> <c-n>
        map window insert <s-tab> <c-p>
        #map window insert <esc> <c-o>
        map window insert <c-q> <c-o>
        hook -once -always window InsertCompletionHide .* %{
            unmap window insert <tab> <c-n>
            unmap window insert <s-tab> <c-p>
            #unmap window insert <esc> <c-o>
            unmap window insert <c-q> <c-o>
        }
    }
}

#   : deletes *scratch* buffers when opening a file
hook global BufOpenFile .* %{
  try %{
    # delete-buffer! *debug*
    delete-buffer! *scratch*
    delete-buffer! *hover*
  }
}

#   : softwrap md files 
hook global WinSetOption filetype=markdown %{
  add-highlighter -override global/markdown-wrap wrap -word
  hook -once -always window WinSetOption filetype=.* %{
    remove-highlighter global/markdown-wrap
  }
}

#   : constantly writes buffers (sometimes useful with lsp)
def -hidden hook_constant_write %{
  hook global NormalIdle .* %{
    perl %{
      if ($ARGV[0] ne "false") { kak "try write" }
    } %val{modified}
  } 
}

perl %{
  if ($ARGV[0] eq "true") { kak "hook_constant_write" }
} %opt{sol_constant_write}
