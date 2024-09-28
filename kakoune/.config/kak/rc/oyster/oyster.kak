# ╭───────────────────────────────────────────────────────────╮
# │ @ Oyster                                                  │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Adds perl scripting support to kakoune.                 ┆
# ╰───────────────────────────────────────────────────────────╯

# > adds highlighting to 'perl %{}' blocks
hook global WinCreate .* %#
  require-module kak
  require-module perl
  try %~ add-highlighter shared/kakrc/code/perl regex '(?:\s|\A)\Kperl(?:(?=\s)|\z)' 0:keyword ~
  try %~ add-highlighter shared/kakrc/perl1 region -recurse '\{' '(^|\h)perl([\s{}\w%/$-|''"])* %\{\K' '\}' ref perl ~
  try %~ add-highlighter shared/kakrc/perl2 region -recurse '\[' '(^|\h)perl([\s{}\w%/$-|''"])* %\[\K' '\]' ref perl ~
  try %~ add-highlighter shared/kakrc/perl3 region -recurse '\(' '(^|\h)perl([\s{}\w%/$-|''"])* %\(\K' '\)' ref perl ~
  try %[ add-highlighter shared/kakrc/perl4 region -recurse '~' '(^|\h)perl([\s{}\w%/$-|''"])* %~\K' '~' ref perl ]
  try %[ add-highlighter shared/kakrc/perl4 region -recurse '<' '(^|\h)perl([\s{}\w%/$-|''"])* %<\K' '>' ref perl ]
  try %~ add-highlighter shared/kakrc/perl5 region -recurse '§' '(^|\h)perl([\s{}\w%/$-|''"])* %§\K' '§' ref perl ~

#


def perl -params 1.. %{
    eval %sh{
        # Encode the command and arguments using base64
        command=$(echo -n "$1" | base64 -w 0)
        shift
        args=$(for arg in "$@"; do echo -n "$arg" | base64 -w 0; echo -n ' '; done)
        
        # Combine encoded command and arguments
        data=$(printf '%s\n%s' "$command" "$args")
        
        # Send the data to the server and get the result
        echo "$data" | socat - UNIX-CONNECT:/tmp/kak_oyster.sock
    }
}

# > example usage of oyster.kak
# > debugs parameters passed to this command
def perl-debug -params 1.. %{ perl %{
  my $first_param = $ARGV[0];
  debug "first param: $first_param";
  foreach my $arg (@ARGV){
    debug "param: $arg";
  }
} %arg{@} }

# executes the server in the background
eval %sh{ 
  nohup perl "$kak_config/rc/oyster/server.pl" >/dev/null 2>&1 & 
}
