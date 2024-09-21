# ╭───────────────────────────────────────────────────────────╮
# │ @ Themes : rc/themes.kak                                  │
# ├───────────────────────────────────────────────────────────┤
# ┆ : Main logic for themes.                                  ┆
# ╰───────────────────────────────────────────────────────────╯

define-command color -params 1.. -docstring %{
Sets a face (color scheme) for a specified scope in Kakoune.
 
USAGE:
  color <scope> <face_name> <color_one> [-alpha <value>] [color_two] [-alpha <value>] [color_three] [-alpha <value>] [-modifiers <mods>]
  
  - <scope>: The scope where the face will be applied (e.g., `global`, `buffer`, etc.).
  - <face_name>: The name of the face to set (e.g., `LineNumbers`, `PrimarySelection`).
  - <color_one>, [color_two], [color_three]: Names of the colors to use. These colors must be options and will be accessed as `%opt{color_name}`. At least one color is required; up to three can be provided. Use 'default' for the default color.
  - [-alpha <value>]: Optional alpha value for the preceding color (0-255).
  - [-modifiers <mods>]: Optional styling modifiers (e.g., `bu` for bold and underline).

EXAMPLES:
  color global LineNumbers red -alpha 255 green blue -modifiers bu
  color global PrimarySelection default blue -alpha 180
  color global MyFace red -alpha 124
} %{
    perl %§
        use strict;
        use warnings;
        my ($scope, $face, @args) = @ARGV;
        my @colors;
        my $modifiers = '';

        for (my $i = 0; $i < @args; $i++) {
            if ($args[$i] eq '-alpha') {
                $colors[-1] = add_alpha($colors[-1], $args[++$i]);
            } elsif ($args[$i] eq '-modifiers') {
                $modifiers = '+' . $args[++$i];
            } else {
                push @colors, wrap_color($args[$i]);
            }
        }

        kak ("set-face $scope $face \"" . join(',', @colors) . $modifiers . "\"\n");

        sub wrap_color {
            return "default" if $_[0] eq "default";
            return "rgb:%opt{" . $_[0] . '}';
        }

        sub add_alpha {
            my ($color, $alpha) = @_;
            $color =~ s/^rgb:/rgba:/;
            return $color . sprintf("%02x", $alpha);
        }
    § %arg{@}
}
