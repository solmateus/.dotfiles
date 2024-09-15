# ╭───────────────────────────────────────────────────────────╮
# │ @ Settings : rc/settings.kak                              │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Changes solkak behavior.                                ┆
# ╰───────────────────────────────────────────────────────────╯

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
decl bool sol_show_whitespaces            true

# : shows matching brackets
decl bool sol_show_matching               false

# : shows numberline
decl bool sol_show_numberline             false
