# ╭───────────────────────────────────────────────────────────╮
# │ @ Rulers : rc/rulers.kak                                  │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Customizable rulers for kakoune.                        ┆
# ╰───────────────────────────────────────────────────────────╯
face global RulersRow "default,default,default+u"
face global RulersCol "default,default,default+r"
face global RulersSpc "default,default,default+r"

perl %{
  my $update_command = "def rulers-update %{\n";
  if ($ARGV[0] ne "false") {
    $update_command = $update_command . "  try %{ rmhl window/rulers_row }\n" . "  addhl window/rulers_row line %val{cursor_line} RulersRow\n";
  }
  if ($ARGV[1] ne "false") {
    $update_command = $update_command . "  try %{ rmhl window/rulers_col }\n" . "  addhl window/rulers_col column %val{cursor_display_column} RulersCol\n";
  }
  if ($ARGV[2] ne "false") {
    $update_command = $update_command . "  try %{ rmhl window/rulers_spc }\n" . "  addhl window/rulers_spc column %opt{sol_special_column} RulersSpc\n";
  }
 
  $update_command = $update_command . "}";

  kak "$update_command";
  kak "hook global -group rulers RawKey .+ %{ rulers-update }";
  
} %opt{sol_highlight_current_line} %opt{sol_highlight_current_column} %opt{sol_highlight_special_column}

rulers-update
