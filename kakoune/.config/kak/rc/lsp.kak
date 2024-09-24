# ╭───────────────────────────────────────────────────────────╮
# │ @ LSP : rc/lsp.kak ! plug.kak                             │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Adds lsp support to kakoune and themes.                 ┆
# ╰───────────────────────────────────────────────────────────╯
plug "kakoune-lsp/kakoune-lsp" do %{
    cargo install --locked --force --path .
    mkdir -p ~/.config/kak-lsp
    cp -n kak-lsp.toml ~/.config/kak-lsp/
}

# > lsp languages
hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp|fish) %{
  lsp-enable-window
  lsp-inlay-diagnostics-enable global
  lsp-inlay-hints-enable global  
}

# >> (c)
hook global WinSetOption filetype=c %{
  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window semantic-tokens
  }
}

# >> (rust)
hook global WinSetOption filetype=rust %{
  set-option window formatcmd 'rustfmt'
  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window semantic-tokens
  }
}

# >>  (typescript)
hook global WinSetOption filetype=typescript %{
  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window semantic-tokens
  }
}

# >> (javascript)
hook global WinSetOption filetype=javascript %{
  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window semantic-tokens
  }
}

# >> (fish)
hook global WinSetOption filetype=fish %{
  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window semantic-tokens
  }
}
