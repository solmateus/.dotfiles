#!/usr/bin/perl
use strict;
use warnings;
use Socket;
use FindBin;
use MIME::Base64;

require "$FindBin::Bin/prelude.pl";

my $socket_path = "/tmp/kak_oyster.sock";
unlink $socket_path if -e $socket_path;

my $exit_command = 'kak_oyster_exit';

socket(my $server, PF_UNIX, SOCK_STREAM, 0) or die "~OY: couldn't create socket: $!\n";
bind($server, pack_sockaddr_un($socket_path)) or die "~OY: couldn't bind to socket: $!\n";
listen($server, SOMAXCONN) or die "~OY: couldn't listen on socket: $!\n";

print "OY ~ oyster server listening on socket $socket_path...\n";

while (my $client = accept(my $connection, $server)) {
    my $encoded_command = <$connection>;
    chomp $encoded_command;
    my $encoded_args = <$connection>;
    chomp $encoded_args;

    # Decode command and arguments
    my $command = decode_base64($encoded_command);
    my @args = map { decode_base64($_) } split ' ', $encoded_args;

    # Capture the output of the eval-ed code
    my ($result, $error) = eval {
        local $| = 1;  # Autoflush output
        my $output = '';

        # Temporarily redirect STDOUT to capture print output
        open my $out, '>', \$output;
        local *STDOUT = $out;

        # Set up @ARGV with the passed arguments
        local @ARGV = @args;

        eval $command;

        if ($@) {
          return (undef, $@);
        }

        return ($output, undef);
    };

    # Send the result back to the client

    if (defined $error) {
      print $connection "echo -debug %{ ERROR: $error }";
    } else {
      if ($result eq $exit_command) {
        print $connection "echo -debug %{ EXITING }";
        close($connection);
        last;
      }
      print $connection "$result"
    }

    close($connection);
}

unlink $socket_path if -e $socket_path;
