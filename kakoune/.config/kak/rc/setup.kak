# ╭───────────────────────────────────────────────────────────╮
# │ @ Setup                                                   │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Loads rc modules.                                       ┆
# ┆ # set global autoloadrc true                              ┆
# ┆   : will find .kak files under rc/ and source them.       ┆
# ╰───────────────────────────────────────────────────────────╯

# : autoloads rc modules if enabled
eval %sh{
  if [[ "$kak_opt_sol_autoloadrc" == "true" ]]; then
    find "$kak_config/rc" -type f | while read -r file; do
    if [[ "$file" == *.kak && "$file" != */rc/setup.kak ]]; then
      echo "echo -debug %{:: sourcing '$file'}"
      echo "source $file"
    fi
  done
  fi
}

# : installs / initializes plug.kak
evaluate-commands %sh{
    plugins="$kak_config/plugins"
    mkdir -p "$plugins"
    [ ! -e "$plugins/plug.kak" ] && \
        git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
    printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}
plug "andreyorst/plug.kak" noload
