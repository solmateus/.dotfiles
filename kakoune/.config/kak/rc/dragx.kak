# ╭───────────────────────────────────────────────────────────╮
# │ @ DragX : rc/dragx.kak                                    │
# ├───────────────────────────────────────────────────────────┤
# ┆ : 'X' and 'x' selects line and drags selection up/down.   ┆
# ┆ : Fork of evanrelf/byline.kak                             ┆
# ╰───────────────────────────────────────────────────────────╯

map global "normal" "x" ": dragx-drag-down<ret>"
map global "normal" "X" ": dragx-drag-up<ret>"

# High-level selection expanding and contracting, based on selection direction
define-command -hidden dragx-drag-down %{
  evaluate-commands -itersel -no-hooks %{
    try %{
      dragx-assert-selection-forwards
      dragx-expand-below
    } catch %{
      dragx-contract-above
    }
  }
}

define-command -hidden dragx-drag-up %{
  evaluate-commands -itersel -no-hooks %{
    try %{
      dragx-assert-selection-forwards
      dragx-contract-below
    } catch %{
      dragx-expand-above
    }
  }
}

# Assertions

define-command -hidden dragx-assert-selection-reduced %{
  # Selections on blank lines are not considered reduced
  execute-keys -draft "<a-K>^$<ret>"
  # Single-character selections are reduced
  execute-keys -draft "<a-k>\A.{,1}\z<ret>"
}

define-command -hidden dragx-assert-selection-forwards %{
  try %{
    # If the selection is just the cursor, we treat it as being in the forwards
    # direction, and can exit early
    dragx-assert-selection-reduced
  } catch %{
    # Otherwise, we need to inspect the selection
    evaluate-commands -no-hooks %sh{
      cursor_row=$(echo "$kak_selection_desc" | cut -d "," -f 2 | cut -d "." -f 1)
      anchor_row=$(echo "$kak_selection_desc" | cut -d "," -f 1 | cut -d "." -f 1)
      [ "$cursor_row" -gt "$anchor_row" ] && exit
      [ "$cursor_row" -lt "$anchor_row" ] && (echo "fail"; exit)
      anchor_col=$(echo "$kak_selection_desc" | cut -d "," -f 1 | cut -d "." -f 2)
      cursor_col=$(echo "$kak_selection_desc" | cut -d "," -f 2 | cut -d "." -f 2)
      [ "$cursor_col" -lt "$anchor_col" ] && (echo "fail"; exit)
    }
  }
}

define-command -hidden dragx-assert-selection-full-lines %{
  # Starts at beginning of line
  execute-keys -draft "<a-:><a-;>;<a-k>\A^<ret>"
  # Ends at end of line
  execute-keys -draft "<a-:>;<a-k>$<ret>"
}

# Low-level selection expanding and contracting primitives

define-command -hidden dragx-expand-above %{
  try %{
    dragx-assert-selection-full-lines
    execute-keys "<a-:><a-;>%val{count}Kx"
  } catch %{
    execute-keys "x<a-:><a-;>"
    evaluate-commands -no-hooks %sh{
      if [ "$kak_count" -gt 1 ]; then
        echo "execute-keys '$((kak_count - 1))Kx'"
      fi
    }
  }
}

define-command -hidden dragx-contract-above %{
  try %{
    dragx-assert-selection-full-lines
    execute-keys "<a-:><a-;>%val{count}Jx"
  } catch %{
    try %{
      execute-keys "<a-x>"
    } catch %{
      execute-keys "x"
    }
    execute-keys "<a-:><a-;>"
    evaluate-commands -no-hooks %sh{
      if [ "$kak_count" -gt 1 ]; then
        echo "execute-keys '$((kak_count - 1))Jx'"
      fi
    }
  }
}

define-command -hidden dragx-expand-below %{
  try %{
    dragx-assert-selection-full-lines
    execute-keys "<a-:>%val{count}Jx"
  } catch %{
    execute-keys "x<a-:>"
    evaluate-commands -no-hooks %sh{
      if [ "$kak_count" -gt 1 ]; then
        echo "execute-keys '$((kak_count - 1))Jx'"
      fi
    }
  }
}

define-command -hidden dragx-contract-below %{
  try %{
    dragx-assert-selection-full-lines
    execute-keys "<a-:>%val{count}Kx"
  } catch %{
    try %{
      execute-keys "<a-x>"
    } catch %{
      execute-keys "x"
    }
    execute-keys "<a-:>"
    evaluate-commands -no-hooks %sh{
      if [ "$kak_count" -gt 1 ]; then
        echo "execute-keys '$((kak_count - 1))Kx'"
      fi
    }
  }
}

