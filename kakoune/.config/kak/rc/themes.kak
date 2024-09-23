# ╭───────────────────────────────────────────────────────────╮
# │ @ Themes : rc/themes.kak                                  │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Main logic for themes.                                  ┆
# ╰───────────────────────────────────────────────────────────╯

# > loads theme
perl %{
  if ($ARGV[0] ne "false") {
    kak "load \"themes/%opt{theme}.kak\""
  }
} %opt{sol_use_solthemes}
