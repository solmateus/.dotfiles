# ╭───────────────────────────────────────────────────────────╮
# │ @ Settings : rc/settings.kak                              │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Changes solkak behavior.                                ┆
# ╰───────────────────────────────────────────────────────────╯

# : use custom solthemes instead of plain colorscheme
decl bool sol_use_solthemes              true

# : sets theme from themes/ folder.
decl str theme                           "catastrophy"

# : starts kak-tree-sitter with kakoune
decl str sol_use_tree_sitter             true

# : attempts to autoload every file in the rc directory
decl bool sol_autoloadrc                 false

# : sets tab width to provided number 
decl int  sol_tab_width                   2

# : disables assistant
decl bool sol_disable_clippy              true

# : disables greeting
decl bool sol_disable_greeting            true

# : sets scrollof distance
decl bool sol_better_scrolloff            true

# : softwraps md files for better readability
decl bool sol_softwrap_md_files           true

# : auto discards *scratch* buffers when a file is open
decl bool sol_autodiscard_scratch_buffers true

# : sequence of keys to exit insert mode
decl str  sol_escape_alias                "jk"

# : writes the current buffer constantly
decl bool sol_constant_write              false

# : shows whitespaces such as spaces and new lines
decl bool sol_show_whitespaces            false

# : shows matching brackets
decl bool sol_show_matching               true

# : shows numberline
decl bool sol_show_numberline             true

# : rulers module
decl int  sol_special_column              80
decl bool sol_highlight_current_line      true
decl bool sol_highlight_current_column    false
decl bool sol_highlight_special_column    true
