# imports
use strict;
use warnings;

# sends first parameter to kakoune *debug* buffer
sub debug {
    my $argument = shift @_;
    print "echo -debug %{$argument}\n"
}

# sends first parameter to kakoune as an echo command 
sub echo {
    my $argument = shift @_;
    print "echo %{$argument}\n"
}

# sends first parameter to kakoune as a command to be executed
sub kak {
    # get all args
    my @args = @_;
    # keep first argument in cmd variable and then remove it from args list
    my $cmd = shift @args;
    # creates an arguments list with the rest of the args wrapped
    my @arguments = map { "%[$_]" } @args;
    # concatenates them with spaces, prepositioned by the command
    my $runner = join(' ', $cmd, @arguments);
    # run it in kakoune
    print "$runner\n"
}
