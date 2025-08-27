# ╭───────────────────────────────────────────────────────────╮
# │ @ HexColors: rc/colorizer.kak                             │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Colorizes hexadecimal color codes in the file.          ┆
# ┆ : Examples: #ff0000 #00ff00 #0000ff #ff2266               ┆
# ╰───────────────────────────────────────────────────────────╯

# hexadecimal colorizer

declare-option -hidden range-specs colorizer

add-highlighter shared/colorizer ranges colorizer

define-command colorizer-enable -docstring 'Enable color preview' %{
    add-highlighter global/colorizer ref colorizer
    hook -group colorizer global NormalIdle .* colorizer-update
}

define-command colorizer-disable -docstring 'Disable color preview' %{
    remove-highlighter global/colorizer
    remove-hooks global colorizer
}

define-command -hidden colorizer-update %{
    try %{
      evaluate-commands -draft -save-regs '/bdf' %{
        execute-keys '%'
        set-register / "(?:#|rgb:)([0-9A-Fa-f]{6})"
        execute-keys 's<ret>'
        set-option window colorizer %val{timestamp}
        evaluate-commands -no-hooks -draft -itersel %{
          set-register d %val{selection_desc}
          execute-keys '1s<ret>'
          set-register b %reg{.}
          set-register f %sh(printf '%s' "$kak_main_reg_dot" | tr '0123456789ABCDEFabcdef' 'fedcba9876543210543210')
          set-option -add window colorizer "%reg{d}|rgb:%reg{f},rgb:%reg{b}"
        }
      }
    } catch %{
        unset-option window colorizer
    }
}

colorizer-enable
