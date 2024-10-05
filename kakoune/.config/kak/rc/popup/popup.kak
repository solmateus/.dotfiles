# ╭───────────────────────────────────────────────────────────╮
# │ @ Popup : rc/popup.kak                                    │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Popup integrated terminal.                              ┆
# ┆ ! REQUIRES: tmux (needs only to be installed).            ┆
# ╰───────────────────────────────────────────────────────────╯
# > installs popup.kak
plug "enricozb/popup.kak" %{
  evaluate-commands %sh{kak-popup init}
}

def pop-terminal %{ popup --title terminal fish }

def pop-file-picker %{
  #popup --title files --kak-script %{edit %opt{popup_output}} -- fzf --border=top --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window 70% --bind 'ctrl-/:change-preview-window(50%|hidden|)'
  popup --title files --kak-script %{edit %opt{popup_output}} "sh %val{config}/rc/popup/sol_fzf.sh"
}

def pop-buffer-picker %{
  perl %{
    my $config = $ARGV[0];
    my $buflist = $ARGV[1];
    my @files = $buflist =~ /'([^']+)'/g;
    my $output = join "\n", @files;
    kak "popup --title buffers --kak-script \"edit %{%opt{popup_output}}\" %{echo '$output' | sh $config/rc/popup/sol_fzf.sh --border=top --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window 70% --bind 'ctrl-/:change-preview-window(50%|hidden|)'}";
    debug "$output";
  } %val{config} %opt{buflist}
}
#def pop-buffer-picker %{
#  perl %{
#    my $buflist = $ARGV[0];
#    my @files = $buflist =~ /'([^']+)'/g;
#    my $output = join "\n", @files;
#    kak "popup --title buffers --kak-script \"edit %{%opt{popup_output}}\" %{echo '$output' | fzf --border=top --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window 70% --bind 'ctrl-/:change-preview-window(50%|hidden|)'}";
#    debug "$output";
#  } %opt{buflist}
#}
