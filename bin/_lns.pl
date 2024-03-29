#!/usr/bin/perl
# desc{ a friendly program for making symbolic links }
$VERSION = '2.01'; # Time-stamp: "2008-08-19 19:26:35 AKDT sburke@cpan.org"

=head1 NAME

lns -- a friendly program for making symbolic links

=head1 SYNOPSIS

  lns target-filespec symlink-filespec
   or
  lns symlink-filespec target-filespec

=head1 DESCRIPTION

It's easy to make mistakes when you're using F<ln -s> to make
symlinks.  So use this program, F<lns>, instead -- it's basically F<ln
-s> plus lots of sanity-checking and DWIM ("do what I mean").
Notably, it doesn't care whether you say C<lns target symlink> or
C<lns symlink target>.

=head1 EXAMPLE USES

Here's a short example session containing attempts to use F<lns> to make
some symlinks:

  % ls -l
  -rw-r--r--  1 sburke dongs 5235 Feb 29 20:52 stuff.html
  
  % lns stuff.html index.html
  Made index.html -> stuff.html
  
  % ls -l
  lrwxr-xr-x  1 sburke dongs   10 Feb 29 22:43 index.html -> stuff.html
  -rw-r--r--  1 sburke dongs 5235 Aug 19 22:43 stuff.html

  % lns funk.txt fank.dat
  But neither funk.txt nor fank.dat exist!

  % lns index.html stuff.html
  But both index.html and stuff.html already exist.
  Maybe rm the symlink index.html (->stuff.html)?

  % lns . foo
  lns doesn't allow symlinking to or from "."

=head1 OPTIONS

Currently, the only command-line option is C<lns -v>, which prints the
lns version number and aborts.

=head1 SEE ALSO

The man page for F<ln>.

=head1 BUG REPORTS

If this program acts up, email me about it, at C<sburke@cpan.org>.

=head1 COPYRIGHT AND DISCLAIMER

Copyright (c) 2004 Sean M. Burke. All rights reserved.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
(See L<perlartistic> and L<perlgpl>.)

The program and its documentation are distributed in the hope that
they will be useful, but without any warranty; without even the
implied warranty of merchantability or fitness for a particular
purpose.  But let me know if it gives you trouble, okay?

=head1 AUTHOR

Sean M. Burke, C<sburke@cpan.org>.

=head1 SCRIPT CATEGORIES

UNIX/System_administration

=head1 CHANGE LOG

=over

=item v2.01 2004-08-20

First CPAN release, after maybe four years of using it on my own and
passing it around to friends.  All that's new in this version is the
documentation, and the "-v" option.

=back

=cut

require 5;

#===========================================================================

if( @ARGV and $ARGV[0] eq '-v' ) {
  print "lns v$VERSION sburke\x40cpan.org\n";
  exit;
} elsif( @ARGV != 2) {
  die "Usage:  lns symlink_to_make source_filespec   (or vice versa)\n",
    "  See 'perldoc lns' for more information.\n",
}
use strict;

#--------------------------------------------------------------------------

sub DEBUG () {0}
my($from, $to) = @ARGV;
 # $from is the spec of the link to make.
 # $to is what it should point to.

die "Can't use empty-string as a filespec.\n"
  unless length $from and length $to;
die "But source and target are the same ($from)!" if $from eq $to;

foreach my $x ($from, $to) {
  if($x =~ s</+$><>s) { # kill trailing /'s
    $x = '/' if $x eq '';
  }
}

die "lns doesn't allow symlinking to or from \"..\"\n"
 if $to eq '..' or $from eq '..';
die "lns doesn't allow symlinking to or from \".\"\n"
 if $to eq '.' or $from eq '.';
  # Technically, it'd be possible to link anything TO . or ..,
  # but it's so icky I'll disallow it.

# Assert that $from doesn't exist and $to exists; and $to's not
#  a symlink, nor '.' nor '..'

if(-e $from or -l $from) {
  # Why not just "-e $from"?  because "-e $from" is false if $from
  #  is a dangling symlink
  #
  if(-e $to or -l $to) {
    # They both exist!
    if(-l $from) {
      if(-l $to) {
        die "But both $from and $to already exist, and are both symlinks!\n";
      } else {
        die "But both $from and $to already exist.\nMaybe rm the symlink $from (->",
         readlink($from), ")?\n";
      }
    } else {
      if(-l $to) {
        die "But both $from and $to already exist.\nMaybe rm the symlink $to (->",
         readlink($to), ")?\n";
      } else {
        die "But both $from and $to already exist, and neither are symlinks.\n";
      }
    }
    
  } else {
    # One exists, the other doesn't, but they need switching.
    ($from, $to) = ($to, $from);
  }
} else {
  # $from doesn't exist
  if(-e $to or -l $to) {
    # One exists, the other doesn't, and they're each in the right place.
  } else {
    die "But neither $from nor $to exist!\n";
  }
}

# If we're putting the symlink somewhere else, make sure
#  the directory we want to put it in exists.
if($from =~ m<^(.*/)[^/]+$>) {
  die
   "But the directory $1 doesn't exist for the symlink $from to be put in!\n"
   unless -e $1;
  # Altho it may actually be a dangling symlink.  Not our problem, really.
}

if($from =~ m</> and $to !~ m<^/>) {
  # The $from is in another dir, and the $to is relative.
  # We /expect/ the $to to be interpreted relative to the pwd.
  # However, we'll need to re-relativize it for sake of symlinking,
  #  so we can have a pathspec to it that's relative to $from's base
  #  directory.
  # If it turns out that interpreting original $to relative to
  #  $from's base dir gives us an existing file too, then scream,
  #  in case the user's mixed up as to which is meant.
  # However, note that unless $to (relative to pwd) existed, we'd
  #  never have gotten this far!
  # This is all a bit of a mess, and if I had it to do over again,
  #  I might just make this refuse to deal with $froms in other dirs
  #  unless $to is absolute.  I don't know if that's detectable, tho,
  #  since all the "what exists / what doesn't" code, above, already
  #  assumes that relative things are relative to PWD.
  
  my $f_dir = $from;
  my $f_base;
  if($f_dir =~ s</([^/]+)$><>) {
    $f_base = $1;
    $f_dir = '/' unless length $f_dir;
  } else {
    die "SNORT";
  }
  
  my $pwd = `pwd`;
  chomp $pwd;
  $pwd = abs2rel($pwd, '/');
  
  my $f_dir_abs  = rel2abs($f_dir, $pwd);
  
  DEBUG and print "f_dir_abs: [$f_dir_abs]   pwd: [$pwd]\n";
  
  my $to_abs     = rel2abs($to, $f_dir_abs);
  my $to_alt_abs = rel2abs($to, $pwd);
  my $to_alt_rel = abs2rel($to_alt_abs, $f_dir_abs);
  
  if(-e $to_abs or -l $to_abs) {
    die "Does \"$to\" refer to $to_alt_abs or $to_abs? Both exist.\n",
        "Depending on which you mean, run one of these:\n",
        "      cd $f_dir; lns $f_base $to\n",          # if rel to $f_dir_abs
        " or:  cd $f_dir; lns $f_base $to_alt_rel\n",  # if rel to $pwd
    ;
  } else {
    # It's not really ambiguous -- the other reading doesn't refer
    #  to an existing file.
    print "(From $from\'s perspective, \"$to\" is \"$to_alt_rel\")\n";
    $to = $to_alt_rel;
  }
}

# Now actually do it
if( symlink($to, $from) ) {
  print "Made $from -> $to\n";
} else {
  die "Couldn't make symlink from $from to $to: $!\n";
}
exit;

# "It isn't necessary to imagine the world ending in fire or ice -- there are
# two other possibilities: one is paperwork, and the other is nostalgia."
#    -- Frank Zappa

#...........................................................................
#
# The subs below here are of my own devising.  For real
# things, use File::PathConvert from CPAN.

sub rel2abs {
  # a bit of a hack?
  my($spec, $base) = @_;
  $base = '' if $spec =~ m<^/>;
  my @bits = grep length $_, split m</+>, "$base/$spec";
  
  DEBUG and print "rel2abs stack: [@bits]\n";
  _dirlist_proc(\@bits);
  DEBUG and print "     outstack: [@bits]\n";
  
  return '/' unless @bits;
  return join '/', '', @bits;
}

sub abs2rel {
  my($spec, $base) = @_;
  return $spec unless $spec =~ m<^/>s; # sanity?
  die "Base <$base> isn't absolute" unless $base =~ m<^/>s;
  return $spec if $base eq '/'; # more sanity
  my @spec = grep length $_, split m</+>, $spec;
  my @base = grep length $_, split m</+>, $base;
  DEBUG and print "1- base [@base]  spec [@spec]\n";

  _dirlist_proc(\@base);
  _dirlist_proc(\@spec);
  
  # eat away common initial parts.  Assumes no parts are ".."!
  my $cut_out;
  while(@base and @spec and $base[0] eq $spec[0]) {
    shift @base; shift @spec;
    ++$cut_out;
  }
  return join '/', '', @spec unless $cut_out;
   # They had nothing in common.  Return an absolute ref, I guess.
  
  # Otherwise cdup to common dir, then have spec bits to go down again.
  unshift @spec, ('..') x scalar(@base);
  DEBUG and print "2- base [@base]  spec [@spec]\n";
  
  return '.' unless @spec;
  return join '/', @spec;
}

sub _dirlist_proc {
  my $b = $_[0];
  for(my $i = 0; $i < @$b;) {
    if($b->[$i] eq '..') {
      # CDUP
      if($i == 0) {
        shift @$b; # just nix myself and run
      } else {
        splice @$b, $i-1, 2;
        --$i;
      }
    } elsif($b->[$i] eq '.') {
      # IDEM
      shift @$b; # just nix myself and run
    } else {
      # Normal path bit.
      ++$i;
    }
  }
}
#---------------------------------------------------------------------------

__END__