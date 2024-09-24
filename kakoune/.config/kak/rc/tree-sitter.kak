# ╭───────────────────────────────────────────────────────────╮
# │ @ Tree-Sitter : rc/tree-sitter.kak ! plug.kak             │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Adds tree-sitter support to kakoune and themes.         ┆
# ╰───────────────────────────────────────────────────────────╯

# : starts kak-tree-sitter
eval %sh{
  if [[ "$kak_opt_sol_use_tree_sitter" == "true" ]]; then
    kak-tree-sitter -dks --init $kak_session
  fi
}
