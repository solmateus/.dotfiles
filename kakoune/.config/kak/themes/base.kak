# ╭───────────────────────────────────────────────────────────╮
# │ @ Base Theme : base.kak                                   │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Basic theme with pretty and saturated colors.           ┆
# ╰───────────────────────────────────────────────────────────╯
# > COLORS
decl str _black  "0F1014"
decl str _dgray3 "1c1e20"
decl str _dgray2 "2c2e30"
decl str _dgray1 "959695"
decl str _lgray  "c4c7c5"
decl str _white  "fefefe"
decl str _red    "cb333a"
decl str _dred   "d8595f"
decl str _green  "188743"
decl str _dgreen "3d9b61"
decl str _yellow "faa821"
decl str _blue   "3870ed"
decl str _dblue  "7ea4f8"
decl str _teal   "007F7F"
decl str _pink   "dc25b6"

# > SOL UI 
decl str Background "%opt{_black}"
decl str Foreground "%opt{_white}"
decl str SubBackground "%opt{_dgray1}"

decl str StatusLineBackground "%opt{_dgray3}"
decl str StatusLineForeground "%opt{_white}"

decl str NormalAccent "%opt{_blue}"
decl str InsertAccent "%opt{_green}"
decl str PromptAccent "%opt{_red}"
decl str NormalAccentLight "%opt{_dblue}"
decl str InsertAccentLight "%opt{_dgreen}"
decl str PromptAccentLight "%opt{_dred}"

decl str NormalStatusLine '{rgb:%opt{NormalAccent},rgb:%opt{StatusLineBackground}}{rgb:%opt{Background},rgb:%opt{NormalAccent}+b}  %val{cursor_line}:%val{cursor_char_column}  %val{bufname}  {rgb:%opt{Background},rgb:%opt{NormalAccent}+bi}kak  '
decl str InsertStatusLine '{rgb:%opt{InsertAccent},rgb:%opt{StatusLineBackground}}{rgb:%opt{Background},rgb:%opt{InsertAccent}+b}  %val{cursor_line}:%val{cursor_char_column}  %val{bufname}  {rgb:%opt{Background},rgb:%opt{InsertAccent}+bi}kak  '
decl str PromptStatusLine '{rgb:%opt{PromptAccent},rgb:%opt{StatusLineBackground}}{rgb:%opt{Background},rgb:%opt{PromptAccent}+b}  %val{cursor_line}:%val{cursor_char_column}  %val{bufname}  {rgb:%opt{Background},rgb:%opt{PromptAccent}+bi}kak  '

# : sets cursor colors to normal
face global PrimaryCursorNormal    "rgb:%opt{NormalAccent}+rb"
face global PrimaryCursorInsert    "rgb:%opt{InsertAccent}+rb"
face global PrimaryCursorPrompt    "rgb:%opt{PromptAccent}+rb"
face global PrimaryCursor          "rgb:%opt{NormalAccent}+rb"
face global PrimaryCursorEolNormal "rgba:%opt{NormalAccent}99,rgb:%opt{InsertAccent}+rb"
face global PrimaryCursorEolInsert "rgba:%opt{InsertAccent}99+rb"
face global PrimaryCursorEolPrompt "rgba:%opt{PromptAccent}99+rb"
face global PrimaryCursorEol       "rgb:%opt{NormalAccentLight},rgb:%opt{InsertAccent}+rb"

face global SecondaryCursor        "rgb:%opt{NormalAccentLight}+rb"
face global SecondaryCursorEol     "rgb:%opt{NormalAccentLight}+rb"

# : sets selection colors
face global PrimarySelection       "default,rgba:%opt{NormalAccent}80+i"
face global SecondarySelection     "default,rgba:%opt{NormalAccent}50+i"

# : sets default statusline
set   global modelinefmt            "%opt{NormalStatusLine}"

# : SOL PLUGINS
decl str SolRulers "%opt{_dgray1}"

# ! SOL COMMANDS : Do not change this.
def apply_normal_accent %{
  face global PrimaryCursor      PrimaryCursorNormal
  face global PrimaryCursorEol   PrimaryCursorEolNormal
  face global LineNumberCursor   "rgb:%opt{Background},rgb:%opt{NormalAccent},default+b"
  set  global modelinefmt        "%opt{NormalStatusLine}"
  face global SecondaryCursor    "rgb:%opt{NormalAccentLight}+rb"
  face global PrimarySelection   "default,rgba:%opt{NormalAccent}80+i"
  face global SecondarySelection "default,rgba:%opt{NormalAccent}50+i"
}

def apply_insert_accent %{
  echo -markup "{rgb:%opt{_black},rgb:%opt{InsertAccent}+b}    INSERT    {rgb:%opt{StatusLineBackground},rgb:%opt{InsertAccent}+b}"
  face global PrimaryCursor      PrimaryCursorInsert
  face global PrimaryCursorEol   PrimaryCursorEolInsert
  face global LineNumberCursor   "rgb:%opt{Background},rgb:%opt{InsertAccent},default+b"
  set  global modelinefmt        "%opt{InsertStatusLine}"
  face global SecondaryCursor    "rgb:%opt{InsertAccentLight}+rb"
  face global PrimarySelection   "default,rgba:%opt{InsertAccent}80+i"
  face global SecondarySelection "default,rgba:%opt{InsertAccent}50+i"
}

def apply_prompt_accent %{
  face global PrimaryCursor      PrimaryCursorPrompt
  face global PrimaryCursorEol   PrimaryCursorEolPrompt
  face global LineNumberCursor   "rgb:%opt{Background},rgb:%opt{PromptAccent},default+b"
  set  global modelinefmt        "%opt{PromptStatusLine}"
  face global SecondaryCursor    "rgb:%opt{PromptAccentLight}+rb"
  face global PrimarySelection   "default,rgba:%opt{PromptAccent}80+i"
  face global SecondarySelection "default,rgba:%opt{PromptAccent}50+i"
}

# : hook: entering insert mode applies insert accent
hook global ModeChange (push|pop):.*insert %{
  apply_insert_accent
}

# : hook: exiting insert mode applies normal accent
hook global ModeChange (push|pop):insert:.* %{
  apply_normal_accent
}

# : hook: entering prompt mode applies prompt accent && exiting goes back
declare-option bool in_prompt_mode false
hook global PromptIdle .* %{
    apply_prompt_accent
    set-option global in_prompt_mode true
    remove-hooks global prompt-exit
    hook -group prompt-exit global NormalIdle .* %{
        evaluate-commands %sh{
            if [ "$kak_opt_in_prompt_mode" = true ]; then
                echo "set-option global in_prompt_mode false"
                echo "apply_normal_accent"
                echo "remove-hooks global prompt-exit"
            fi
        }
    }
}

# > BUILTINS
face global LineNumbers        "rgb:%opt{_dgray2},rgb:%opt{_black}"
face global LineNumberCursor   "rgb:%opt{_black},rgb:%opt{NormalAccent}"
face global LineNumbersWrapped "rgb:%opt{_dgray1},rgb:%opt{_lgray}" 
face global Default            "rgb:%opt{_white},rgb:%opt{_black}"
face global MenuForeground     "rgb:%opt{_white},rgb:%opt{_dgray2}"
face global MenuBackground     "rgb:%opt{_dgray2},rgb:%opt{_dgray1}"
face global MenuInfo           "rgb:%opt{_white},rgb:%opt{_dgray2}"
face global Information        "rgb:%opt{_dgray2},rgb:%opt{_dgray1}"
face global Error              "rgb:%opt{_black},rgb:%opt{_red}+b" 
face global DiagnosticError    "rgb:%opt{_black},rgb:%opt{_red}+b"
face global DiagnosticWarning  "rgb:%opt{_yellow}"
face global Prompt             "rgb:%opt{_black},rgb:%opt{_red}+b"
face global MatchingChar       "rgb:%opt{_yellow},rgb:%opt{_black}+b"
face global Whitespace         "rgb:%opt{_lgray},rgb:%opt{_black}+f"
face global WrapMarker         Whitespace
face global BufferPadding      "rgb:%opt{_black},rgb:%opt{_black}"
face global StatusLineInfo     "rgb:%opt{_black},rgb:%opt{_red}"
face global StatusLineMode     "rgb:%opt{_black},rgb:%opt{_red}"
face global StatusLineValue    "rgb:%opt{_black},rgb:%opt{_red}"
face global StatusLineCursor   "rgb:%opt{_black},rgb:%opt{_red}"
face global StatusCursor       "rgb:%opt{_black},rgb:%opt{_red}" 
face global StatusLine         "rgb:%opt{StatusLineForeground},rgb:%opt{StatusLineBackground}" 

# > MARKUP
face global title  "rgb:%opt{_white}+b"
face global header "rgb:%opt{_dgray1}+b"
face global bold   "rgb:%opt{_blue}+b"
face global italic "rgb:%opt{_blue}+b"
face global mono   "rgb:%opt{_green}"
face global block  "rgb:%opt{_green}"
face global link   "rgb:%opt{_blue}"
face global bullet "rgb:%opt{_yellow}"
face global list   "rgb:%opt{_yellow}"

# > CODE
face global value         "rgb:%opt{_yellow}"
face global type          "rgb:%opt{_yellow}"
face global variable      "rgb:%opt{_white}"
face global module        "rgb:%opt{_red}"
face global function      "rgb:%opt{_lgray}"
face global string        "rgb:%opt{_green}"
face global keyword       "rgb:%opt{_blue}"
face global operator      "rgb:%opt{_lgray}"
face global attribute     "rgb:%opt{_yellow}"
face global comment       "rgb:%opt{_dgray1}+i"
face global documentation comment
face global meta          "rgb:%opt{_yellow}"
face global builtin       "rgb:%opt{_red}"

# > KAK-LSP
face global InlayDiagnosticError   Error
face global LineFlagError          Error
face global DiagnosticError        Error
face global InlayHint              "+d@type"
face global parameter              "+i@variable"
face global enum                   "rgb:%opt{_lgray}"
face global InlayDiagnosticWarning "rgb:%opt{_dgray1}"
face global InlayDiagnosticInfo    "rgb:%opt{_blue}"
face global InlayDiagnosticHint    "rgb:%opt{_green}"
face global LineFlagWarning        "rgb:%opt{_dgray1}"
face global LineFlagInfo           "rgb:%opt{_blue}"
face global LineFlagHint           "rgb:%opt{_green}"
face global DiagnosticWarning      "default,default,rgb:%opt{_dgray1}+c"
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

# > KAK RAINBOWER
try %{ set-option global rainbow_colors "rgb:%opt{_yellow}" "rgb:%opt{_blue}" "rgb:%opt{_green}" }

# > FANCY UNDERLINES : backwards compatibility with one theme
define-command -override -hidden one-enable-fancy-underlines %{
    echo -debug "one-enable-fancy-underlines is deprecated - curly underlines are enabled by default"
}

face global ts_attribute                    attribute
face global ts_comment                      comment
face global ts_conceal                      "rgb:%opt{_blue}+i"
face global ts_constant                     "rgb:%opt{_yellow}"
face global ts_constant_builtin_boolean     "rgb:%opt{_lgray}"
face global ts_constant_character           "rgb:%opt{_teal}"
face global ts_constant_macro               "rgb:%opt{_blue}"
face global ts_constructor                  "rgb:%opt{_lgray}"
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
face global ts_label                        "rgb:%opt{_lgray}+i"
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
face global ts_markup_quote                 "rgb:%opt{_dgray1}"
face global ts_markup_raw                   "rgb:%opt{_green}"
face global ts_markup_strikethrough         "rgb:%opt{_dgray1}+s"
face global ts_namespace                    "rgb:%opt{_blue}+i"
face global ts_operator                     "rgb:%opt{_lgray}"
face global ts_property                     "rgb:%opt{_lgray}"
face global ts_punctuation                  "rgb:%opt{_dgray1}"
face global ts_punctuation_special          "rgb:%opt{_lgray}"
face global ts_special                      "rgb:%opt{_blue}"
face global ts_spell                        "rgb:%opt{_blue}"
face global ts_string                       string
face global ts_string_regex                 "rgb:%opt{_pink}"
face global ts_string_regexp                "rgb:%opt{_pink}"
face global ts_string_escape                "rgb:%opt{_lgray}"
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
face global ts_warning                      "rgb:%opt{_dgray1}+b"

