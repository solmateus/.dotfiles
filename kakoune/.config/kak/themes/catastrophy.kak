# ╭───────────────────────────────────────────────────────────╮
# │ @ CatAstrophe Theme : CatAstrophe.kak                     │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Beautifyl theme with pretty and saturated colors.       ┆
# ┆ : Meow!                                               >:3 ┆
# ╰───────────────────────────────────────────────────────────╯

# ╭───────────────────────────────────────────────────────────╮
# │ > Colors                                                  │
# ╰───────────────────────────────────────────────────────────╯
# : boring straight colors
decl str _black  "0F1014"
decl str _gray3  "1c1e20"
decl str _gray2  "2c2e30"
decl str _gray1  "959695"
decl str _gray   "c4c7c5"
decl str _white  "fefefe"

# : cool gay colors
decl str _red    "cb333a"
decl str _dred   "d8595f"
decl str _green  "188743"
decl str _dgreen "3d9b61"
decl str _yellow "faa821"
decl str _blue   "3870ed"
decl str _dblue  "7ea4f8"
decl str _teal   "007F7F"
decl str _pink   "dc25b6"

# ╭───────────────────────────────────────────────────────────╮
# │ > Settings                                                │
# ╰───────────────────────────────────────────────────────────╯
# : defaults
decl str SolBackground                   "%opt{_black}"
decl str SolForeground                   "%opt{_white}"
# : accents
decl str SolNormalAccent                 "%opt{_blue}"
decl str SolInsertAccent                 "%opt{_green}"
decl str SolPromptAccent                 "%opt{_red}"
decl str SolNormalAccentLight            "%opt{_dblue}"
decl str SolInsertAccentLight            "%opt{_dgreen}"
decl str SolPromptAccentLight            "%opt{_dred}"
#  : transparency levels
decl int    SolAccentHighAlpha           75
decl int    SolAccentLowAlpha            45
# : line number cursor
face global SolLineNumberCursorNormal    "rgb:%opt{SolBackground},rgb:%opt{SolNormalAccent}+b"
face global SolLineNumberCursorInsert    "rgb:%opt{SolBackground},rgb:%opt{SolInsertAccent}+b"
face global SolLineNumberCursorPrompt    "rgb:%opt{SolBackground},rgb:%opt{SolPromptAccent}+b"
# : primary cursor
face global SolPrimaryCursorNormal       "rgb:%opt{SolNormalAccent}+rb"
face global SolPrimaryCursorInsert       "rgb:%opt{SolInsertAccent}+rb"
face global SolPrimaryCursorPrompt       "rgb:%opt{SolPromptAccent}+rb"
face global SolPrimaryCursorEolNormal    "rgb:%opt{SolNormalAccentLight}+rb"
face global SolPrimaryCursorEolInsert    "rgb:%opt{SolInsertAccentLight}+rb"
face global SolPrimaryCursorEolPrompt    "rgb:%opt{SolPromptAccentLight}+rb"
# : secondary cursor
face global SolSecondaryCursorNormal     "rgb:%opt{SolNormalAccentLight}+rb"
face global SolSecondaryCursorInsert     "rgb:%opt{SolInsertAccentLight}+rb"
face global SolSecondaryCursorPrompt     "rgb:%opt{SolPromptAccentLight}+rb"
face global SolSecondaryCursorEolNormal  "rgb:%opt{SolNormalAccentLight}+rb"
face global SolSecondaryCursorEolInsert  "rgb:%opt{SolInsertAccentLight}+rb"
face global SolSecondaryCursorEolPrompt  "rgb:%opt{SolPromptAccentLight}+rb"
# : selections
face global SolPrimarySelectionNormal    "default,rgba:%opt{SolNormalAccent}%opt{SolAccentHighAlpha}+i"
face global SolSecondarySelectionNormal  "default,rgba:%opt{SolNormalAccent}%opt{SolAccentLowAlpha}+i"
face global SolPrimarySelectionInsert    "default,rgba:%opt{SolInsertAccent}%opt{SolAccentHighAlpha}+i"
face global SolSecondarySelectionInsert  "default,rgba:%opt{SolInsertAccent}%opt{SolAccentLowAlpha}+i"
face global SolPrimarySelectionPrompt    "default,rgba:%opt{SolPromptAccent}%opt{SolAccentHighAlpha}+i"
face global SolSecondarySelectionPrompt  "default,rgba:%opt{SolPromptAccent}%opt{SolAccentLowAlpha}+i"
# : statusline
decl str    SolStatusLineForeground      "%opt{_white}"
decl str    SolStatusLineBackground      "%opt{_gray3}"
decl str    SolStatusLineNormal          '{rgb:%opt{SolNormalAccent},rgb:%opt{SolStatusLineBackground}}{rgb:%opt{SolBackground},rgb:%opt{SolNormalAccent}+b}  %val{cursor_line}:%val{cursor_char_column}  %val{bufname}  {rgb:%opt{SolBackground},rgb:%opt{SolNormalAccent}+bi}kak  '
decl str    SolStatusLineInsert          '{rgb:%opt{SolInsertAccent},rgb:%opt{SolStatusLineBackground}}{rgb:%opt{SolBackground},rgb:%opt{SolInsertAccent}+b}  %val{cursor_line}:%val{cursor_char_column}  %val{bufname}  {rgb:%opt{SolBackground},rgb:%opt{SolInsertAccent}+bi}kak  '
decl str    SolStatusLinePrompt          '{rgb:%opt{SolPromptAccent},rgb:%opt{SolStatusLineBackground}}{rgb:%opt{SolBackground},rgb:%opt{SolPromptAccent}+b}  %val{cursor_line}:%val{cursor_char_column}  %val{bufname}  {rgb:%opt{SolBackground},rgb:%opt{SolPromptAccent}+bi}kak  '
decl str    SolInsertTag                 "{rgb:%opt{_black},rgb:%opt{SolInsertAccent}+b}    INSERT    {rgb:%opt{SolStatusLineBackground},rgb:%opt{SolInsertAccent}+b}"

# ╭───────────────────────────────────────────────────────────╮
# │ @ Themes : Handles statusline and mode color changes.     │
# ╰───────────────────────────────────────────────────────────╯
# : applies normal colors
def theme-apply-normal-colors %{
  # : line number cursor
  face global LineNumberCursor          SolLineNumberCursorNormal
  # : primary cursor
  face global PrimaryCursor             SolPrimaryCursorNormal   
  face global PrimaryCursorEol          SolPrimaryCursorEolNormal   
  face global PrimarySelection          SolPrimarySelectionNormal   
  # : secondary cursor
  face global SecondaryCursor           SolSecondaryCursorNormal   
  face global SecondaryCursorEol        SolSecondaryCursorEolNormal   
  face global SecondarySelection        SolSecondarySelectionNormal   
  # : selections
  face global PrimarySelection          SolPrimarySelectionNormal
  face global SecondarySelection        SolSecondarySelectionNormal
  # : statusline
  set global modelinefmt                "%opt{SolStatusLineNormal}"
  echo ""
}

# : applies insert colors
def theme-apply-insert-colors %{
  # : line number cursor
  face global LineNumberCursor          SolLineNumberCursorInsert
  # : primary cursor
  face global PrimaryCursor             SolPrimaryCursorInsert   
  face global PrimaryCursorEol          SolPrimaryCursorEolInsert   
  face global PrimarySelection          SolPrimarySelectionInsert   
  # : secondary cursor
  face global SecondaryCursor           SolSecondaryCursorInsert   
  face global SecondaryCursorEol        SolSecondaryCursorEolInsert   
  face global SecondarySelection        SolSecondarySelectionInsert   
  # : selections
  face global PrimarySelection          SolPrimarySelectionInsert
  face global SecondarySelection        SolSecondarySelectionInsert
  # : statusline
  set global modelinefmt                "%opt{SolStatusLineInsert}"
  # : insert echo
  echo -markup                          "%opt{SolInsertTag}"
}

# : applies prompt colors
def theme-apply-prompt-colors %{
  # : line number cursor
  face global LineNumberCursor          SolLineNumberCursorPrompt
  # : primary cursor
  face global PrimaryCursor             SolPrimaryCursorPrompt   
  face global PrimaryCursorEol          SolPrimaryCursorEolPrompt   
  face global PrimarySelection          SolPrimarySelectionPrompt   
  # : secondary cursor
  face global SecondaryCursor           SolSecondaryCursorPrompt   
  face global SecondaryCursorEol        SolSecondaryCursorEolPrompt   
  face global SecondarySelection        SolSecondarySelectionPrompt   
  # : selections
  face global PrimarySelection          SolPrimarySelectionPrompt
  face global SecondarySelection        SolSecondarySelectionPrompt
  # : statusline
  set global modelinefmt                "%opt{SolStatusLinePrompt}"
}

# : Updates theme according to mode.
hook global ModeChange (push|pop):.*insert %{ theme-apply-insert-colors }
hook global ModeChange (push|pop):insert:.* %{ theme-apply-normal-colors }
hook global ModeChange (push|pop):.*prompt %{ theme-apply-prompt-colors }
hook global ModeChange (push|pop):prompt.* %{ theme-apply-normal-colors }

# ╭───────────────────────────────────────────────────────────╮
# │ @ Builtins                                                │
# ╰───────────────────────────────────────────────────────────╯
face global LineNumbers        "rgb:%opt{_gray2},rgb:%opt{_black}"
#face global LineNumberCursor   "rgb:%opt{_black},rgb:%opt{SolNormalAccent}"
face global LineNumbersWrapped "rgb:%opt{_gray3},rgb:%opt{_black}" 
face global Default            "rgb:%opt{_white},rgb:%opt{_black}"
face global MenuForeground     "rgb:%opt{_white},rgb:%opt{_gray2}"
face global MenuBackground     "rgb:%opt{_gray2},rgb:%opt{_gray1}"
face global MenuInfo           "rgb:%opt{_white},rgb:%opt{_gray2}"
face global Information        "rgb:%opt{_gray2},rgb:%opt{_gray1}"
face global Error              "rgb:%opt{_black},rgb:%opt{_red}+bF" 
face global DiagnosticError    "rgb:%opt{_black},rgb:%opt{_red}+bF"
face global DiagnosticWarning  "rgb:%opt{_yellow}"
face global Prompt             "rgb:%opt{_black},rgb:%opt{_red}+b"
face global MatchingChar       "rgb:%opt{_yellow},rgb:%opt{_black}+b"
face global Whitespace         "rgb:%opt{_gray},rgb:%opt{_black}+f"
face global WrapMarker         Whitespace
face global BufferPadding      "rgb:%opt{_black},rgb:%opt{_black}"
face global StatusLineInfo     "rgb:%opt{_black},rgb:%opt{_red}"
face global StatusLineMode     "rgb:%opt{_black},rgb:%opt{_red}"
face global StatusLineValue    "rgb:%opt{_black},rgb:%opt{_red}"
face global StatusLineCursor   "rgb:%opt{_black},rgb:%opt{_red}"
face global StatusCursor       "rgb:%opt{_black},rgb:%opt{_red}" 
face global StatusLine         "rgb:%opt{SolStatusLineForeground},rgb:%opt{SolStatusLineBackground}"

# ╭───────────────────────────────────────────────────────────╮
# │ @ Markup                                                  │
# ╰───────────────────────────────────────────────────────────╯
face global title  "rgb:%opt{_white}+b"
face global header "rgb:%opt{_gray1}+b"
face global bold   "rgb:%opt{_blue}+b"
face global italic "rgb:%opt{_blue}+b"
face global mono   "rgb:%opt{_green}"
face global block  "rgb:%opt{_green}"
face global link   "rgb:%opt{_blue}"
face global bullet "rgb:%opt{_yellow}"
face global list   "rgb:%opt{_yellow}"

# ╭───────────────────────────────────────────────────────────╮
# │ @ Code                                                    │
# ╰───────────────────────────────────────────────────────────╯
face global value         "rgb:%opt{_yellow}"
face global type          "rgb:%opt{_yellow}"
face global variable      "rgb:%opt{_white}"
face global module        "rgb:%opt{_red}"
face global function      "rgb:%opt{_gray}"
face global string        "rgb:%opt{_green}"
face global keyword       "rgb:%opt{_blue}"
face global operator      "rgb:%opt{_gray}"
face global attribute     "rgb:%opt{_yellow}"
face global comment       "rgb:%opt{_gray1}+i"
face global documentation comment
face global meta          "rgb:%opt{_yellow}"
face global builtin       "rgb:%opt{_red}"

# ╭───────────────────────────────────────────────────────────╮
# │ @ LSP                                                     │
# ╰───────────────────────────────────────────────────────────╯
# : basic
face global InlayDiagnosticError   Error
face global LineFlagError          Error
face global DiagnosticError        Error
face global InlayHint              "+d@type"
face global parameter              "+i@variable"
face global enum                   "rgb:%opt{_gray}"
face global InlayDiagnosticWarning "rgb:%opt{_gray1}"
face global InlayDiagnosticInfo    "rgb:%opt{_blue}"
face global InlayDiagnosticHint    "rgb:%opt{_green}"
face global LineFlagWarning        "rgb:%opt{_gray1}"
face global LineFlagInfo           "rgb:%opt{_blue}"
face global LineFlagHint           "rgb:%opt{_green}"
face global DiagnosticWarning      "default,default,rgb:%opt{_gray1}+c"
face global DiagnosticInfo         "default,default,rgb:%opt{_blue}+c"
face global DiagnosticHint         "default,default,rgb:%opt{_green}+c"
# : info boxes
face global InfoDefault Information
face global InfoBlock block
face global InfoBlockQuote block
face global InfoBullet bullet
face global InfoHeader header
face global InfoLink link
face global InfoLinkMono header
face global InfoMono mono
face global InfoRule comment
face global InfoDiagnosticError InlayDiagnosticError
face global InfoDiagnosticHint InlayDiagnosticHint
face global InfoDiagnosticInformation InlayDiagnosticInfo
face global InfoDiagnosticWarning InlayDiagnosticWarning

# ╭───────────────────────────────────────────────────────────╮
# │ @ Tree-Sitter                                             │
# ╰───────────────────────────────────────────────────────────╯

face global ts_attribute                    attribute
face global ts_comment                      comment
face global ts_conceal                      "rgb:%opt{_blue}+i"
face global ts_constant                     "rgb:%opt{_yellow}"
face global ts_constant_builtin_boolean     "rgb:%opt{_gray}"
face global ts_constant_character           "rgb:%opt{_teal}"
face global ts_constant_macro               "rgb:%opt{_blue}"
face global ts_constructor                  "rgb:%opt{_gray}"
face global ts_diff_plus                    "rgb:%opt{_green}"
face global ts_diff_minus                   "rgb:%opt{_red}"
face global ts_diff_delta                   "rgb:%opt{_blue}"
face global ts_diff_delta_moved             "rgb:%opt{_blue}"
face global ts_error                        "rgb:%opt{_blue}+b"
face global ts_function                     "rgb:%opt{_blue}"
face global ts_function_builtin             "rgb:%opt{_blue}+i"
face global ts_function_macro               "rgb:%opt{_blue}"
face global ts_hint                         "rgb:%opt{_blue}+b"
face global ts_info                         "rgb:%opt{_teal}+b"
face global ts_keyword                      "rgb:%opt{_blue}"
face global ts_keyword_conditional          "rgb:%opt{_blue}+i"
face global ts_keyword_control_conditional  "rgb:%opt{_blue}+i"
face global ts_keyword_control_directive    "rgb:%opt{_blue}+i"
face global ts_keyword_control_import       "rgb:%opt{_blue}+i"
face global ts_keyword_directive            "rgb:%opt{_blue}+i"
face global ts_label                        "rgb:%opt{_gray}+i"
face global ts_markup_bold                  "rgb:%opt{_yellow}+b"
face global ts_markup_heading               "rgb:%opt{_red}"
face global ts_markup_heading_1             "rgb:%opt{_red}"
face global ts_markup_heading_2             "rgb:%opt{_blue}"
face global ts_markup_heading_3             "rgb:%opt{_green}"
face global ts_markup_heading_4             "rgb:%opt{_yellow}"
face global ts_markup_heading_5             "rgb:%opt{_pink}"
face global ts_markup_heading_6             "rgb:%opt{_teal}"
face global ts_markup_heading_marker        "rgb:%opt{_yellow}+b"
face global ts_markup_italic                "rgb:%opt{_pink}+i"
face global ts_markup_list_checked          "rgb:%opt{_green}"
face global ts_markup_list_numbered         "rgb:%opt{_blue}+i"
face global ts_markup_list_unchecked        "rgb:%opt{_teal}"
face global ts_markup_list_unnumbered       "rgb:%opt{_blue}"
face global ts_markup_link_label            "rgb:%opt{_blue}"
face global ts_markup_link_url              "rgb:%opt{_teal}+u"
face global ts_markup_link_uri              "rgb:%opt{_teal}+u"
face global ts_markup_link_text             "rgb:%opt{_blue}"
face global ts_markup_quote                 "rgb:%opt{_gray1}"
face global ts_markup_raw                   "rgb:%opt{_green}"
face global ts_markup_strikethrough         "rgb:%opt{_gray1}+s"
face global ts_namespace                    "rgb:%opt{_blue}+i"
face global ts_operator                     "rgb:%opt{_gray}"
face global ts_property                     "rgb:%opt{_gray}"
face global ts_punctuation                  "rgb:%opt{_gray1}"
face global ts_punctuation_special          "rgb:%opt{_gray}"
face global ts_special                      "rgb:%opt{_blue}"
face global ts_spell                        "rgb:%opt{_blue}"
face global ts_string                       string
face global ts_string_regex                 "rgb:%opt{_pink}"
face global ts_string_regexp                "rgb:%opt{_pink}"
face global ts_string_escape                "rgb:%opt{_gray}"
face global ts_string_special               "rgb:%opt{_blue}"
face global ts_string_special_path          "rgb:%opt{_green}"
face global ts_string_special_symbol        "rgb:%opt{_blue}"
face global ts_string_symbol                "rgb:%opt{_red}"
face global ts_tag                          "rgb:%opt{_blue}"
face global ts_tag_error                    "rgb:%opt{_blue}"
face global ts_text                         "rgb:%opt{_white}"
face global ts_text_title                   "rgb:%opt{_blue}"
face global ts_type                         type
face global ts_type_enum_variant            "rgb:%opt{_teal}"
face global ts_variable                     variable
face global ts_variable_builtin             builtin
face global ts_variable_other_member        "rgb:%opt{_teal}"
face global ts_variable_parameter           "rgb:%opt{_red}+i"
face global ts_warning                      "rgb:%opt{_gray1}+b"

# ╭───────────────────────────────────────────────────────────╮
# │ @ Rainbower                                               │
# ╰───────────────────────────────────────────────────────────╯
try %{ set-option global rainbow_colors "rgb:%opt{_yellow}" "rgb:%opt{_blue}" "rgb:%opt{_green}" }

# ╭───────────────────────────────────────────────────────────╮
# │ ! Other                                                   │
# ╰───────────────────────────────────────────────────────────╯
# > FANCY UNDERLINES : backwards compatibility with one theme
define-command -override -hidden one-enable-fancy-underlines %{
    echo -debug "one-enable-fancy-underlines is deprecated - curly underlines are enabled by default"
}

# ╭───────────────────────────────────────────────────────────╮
# │ @ Rulers                                                  │
# ╰───────────────────────────────────────────────────────────╯
face global RulersRow "default,rgb:%opt{_gray3},default"
face global RulersCol "default,rgb:%opt{_gray3},default"
face global RulersSpc "default,rgb:%opt{_gray3},default"

# ╭───────────────────────────────────────────────────────────╮
# │ : Starts on normal mode colors.                           │
# ╰───────────────────────────────────────────────────────────╯
theme-apply-normal-colors
