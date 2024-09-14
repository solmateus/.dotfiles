# ╭───────────────────────────────────────────────────────────╮
# │ @ Oyster                                                  │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Adds perl scripting support to kakoune.                 ┆
# ╰───────────────────────────────────────────────────────────╯

# > adds highlighting to 'perl %{}' blocks
hook global WinCreate .* %#
  require-module kak
  require-module perl
  try %[ add-highlighter shared/kakrc/code/perl regex '(?:\s|\A)\Kperl(?:(?=\s)|\z)' 0:keyword ]
  try %[ add-highlighter shared/kakrc/perl1 region -recurse '\{' '(^|\h)perl([\s{}\w%/$-|''"])* %\{\K' '\}' ref perl ]
#

# > perl command to parse perl code
def perl -params 1.. %{
  require-module kak
  eval %sh{
    # Read the contents of the prelude file
    prelude=$(cat "$kak_config/rc/oyster/prelude.pl")
    # Combine the prelude and the provided Perl code
    perl_code=$(printf '%s\n%s' "$prelude" "$1")
    # Shift the first argument (the Perl code)
    shift
    # Execute the combined Perl code
    perl -e "$perl_code" "$@"
  }
}

# > example usage of oyster.kak
# > debugs parameters passed to this command
def perl-debug -params 1.. %{ perl %{
  my $first_param = $ARGV[0];
  debug "first param: $first_param";
  foreach my $arg (@ARGV){
    debug "param: $arg\n";
  }
} %arg{@} }

