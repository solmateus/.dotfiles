# ╭───────────────────────────────────────────────────────────╮
# │ @ Buffers : rc/buffers.kak                                │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Adds useful buffer commands and options.                ┆
# ╰───────────────────────────────────────────────────────────╯

decl         str currbuf           ""
decl         str buflist           ""
decl -hidden str buflist_fmt       ""
decl -hidden int _acc_buflist      01
decl -hidden str buflist_face      ""
decl -hidden str buflist_fmt_face  ""

# : updates buffer lists
def update-buffer-lists %{
    set global buflist      ""
    set global buflist_fmt  ""
    set global _acc_buflist 01
    eval -no-hooks -buffer * %{
        set global buflist "%opt{buflist}'%val{bufname}' "
        set global buflist_fmt "%opt{buflist_fmt}\n%opt{_acc_buflist} > '%val{bufname}'"
    }
}

# : switches to buffer at provided id
def goto-buffer -params 1 %{ perl %{
    my $index = 0;
    my $target = $ARGV[0];
    my $buflist = $ARGV[1];
    foreach my $buffer ($buflist =~ /'(.*?)'/g) {
        $index++;
        if ($index == $target) {
            print "buffer $buffer";
        }
    }
} %arg{1} %opt{buflist} }

# : updates currbuf
hook global WinDisplay .* %{ set global currbuf %val{bufname} }

# : updates buffer lists everytime a window is displayed
hook global WinDisplay .* %{
    set global currbuf %val{bufname}
    update-buffer-lists
}

