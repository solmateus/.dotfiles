# ╭───────────────────────────────────────────────────────────╮
# │ @ Setup                                                   │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Loads rc modules.                                       ┆
# ┆ # set global autoloadrc true                              ┆
# ┆   : will find .kak files under rc/ and source them.       ┆
# ╰───────────────────────────────────────────────────────────╯
eval %sh{
  if [[ "$kak_opt_autoloadrc" == "true" ]]; then
    find "$kak_config/rc" -type f | while read -r file; do
    if [[ "$file" == *.kak && "$file" != */rc/setup.kak ]]; then
      echo "echo -debug %{:: sourcing '$file'}"
      echo "source $file"
    fi
  done
  fi
}

# TODO: % move this to a proper module.
set global tabstop 2
set global indentwidth 2 
