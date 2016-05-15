=begin
CSCI3180 Principles of Programming Languages
--- Declaration ---
I declare that the assignment here submitted is original except for source material explicitly acknowledged.
I also acknowledge that I am aware of University policy and regulations on honesty in academic work,
and of the disciplinary guidelines and procedures applicable to breaches of such policy and regulations,
as contained in the http://www.cuhk.edu.hk/policy/academichonesty/
Assignment 3
Name: KO Chi Keung
Student ID: 1155033234
Email Addr: ckko3@se.cuhk.edu.hk
=cut

use feature ':5.10';
#use strict;
use warnings;

# Reversi

# class Reversi
package Reversi;

# constructor : initialize instance variables
sub new {
  my $class = shift;  # package name
  my $self = {};  # reference to empty hash

  # prompt the user to choose the player type for player X and player O
  print "First player is (1) Computer or (2) Human? ";
  my $input = <>;
  chomp ($input);
  if ($input == 1) {
    $self->{black} = Computer->new('X');
    print "Player X is Computer";
  }
  else {
    $self->{black} = Human->new('X');
    print "Player X is Human";
  }
  print "\n";
  print "Second player is (1) Computer or (2) Human? ";
  $input = <>;
  chomp ($input);
  if ($input == 1) {
    $self->{white} = Computer->new('O');
    print "Player O is Computer";
  }
  else {
    $self->{white} = Human->new('O');
    print "Player O is Human";
  }
  print "\n";

  # 2D array of size 8x8 representing the game board
  for my $i (0..7) {
    for my $j (0..7) {
        $self->{board}[$i][$j] = '.';
    }
  }
  # initial configuration
  $self->{board}[3][4] = $self->{board}[4][3] = 'X';
  $self->{board}[3][3] = $self->{board}[4][4] = 'O';

  # Player X takes the first turn
  $self->{turn} = 'X';

  bless $self, $class;
  return $self;
}

# print game board and count of pieces to the console
sub printBoard {
  my ($self) = @_;
  $self->{XCount} = $self->{OCount} = 0; # count of X pieces and O pieces
  print "  0 1 2 3 4 5 6 7", "\n";
  for my $i (0..7) {
    printf "%-2d", $i;
    for my $j (0..7) {
        printf "%-2s", $self->{board}[$i][$j];
        if ($self->{board}[$i][$j] eq 'X') {
          $self->{XCount}++;
        }
        if ($self->{board}[$i][$j] eq 'O') {
          $self->{OCount}++;
        }
    }
    print "\n";
  }
  print "Player X: ", $self->{XCount}, "\n";
  print "Player O: ", $self->{OCount}, "\n";
}

# check whether within range
sub range {
  my ($self, $r, $c) = @_;
  return ($r >= 0 && $r <= 7 && $c >=0 && $c <= 7);
}

# check whether can flip opponent's piece, return array containing flippable position
sub checkFlip {
  my ($self, $r, $c) = @_;
  my $opponent = ($self->{turn} eq 'X')? 'O' : 'X';
  my @flip; # array containing position of flippable opponent's pieces
  my $x; my $y; my $k; my $pushCount;

  for my $i (1..8) {  # 8 directions
    $pushCount = 0;
    for my $j (1..8) {
        # horizontal
        if ($i == 1) { $x = $r; $y = $c-$j; }
        if ($i == 2) { $x = $r; $y = $c+$j; }
        # vertical
        if ($i == 3) { $x = $r-$j; $y = $c; }
        if ($i == 4) { $x = $r+$j; $y = $c; }
        # left-diagonal
        if ($i == 5) { $x = $r-$j; $y = $c-$j; }
        if ($i == 6) { $x = $r+$j; $y = $c+$j; }
        # right-diagonal
        if ($i == 7) { $x = $r-$j; $y = $c+$j; }
        if ($i == 8) { $x = $r+$j; $y = $c-$j; }

      if ($self->range($x, $y) && ($self->{board}[$x][$y] eq $opponent)) {
        # opponent's pieces
        push (@flip, [$x, $y]);  # push the position to array
        $pushCount++;
      } else {
        # out of board or free space
        if (!($self->range($x, $y)) || ($self->{board}[$x][$y] eq '.')) {
          for ($k = 0; $k < $pushCount; $k++) {
            pop @flip; # pop array
          }
        }
        last; # break the loop
      }

    }
  }

  return @flip;

}

sub endGame {
  my ($self) = @_;

  if ($self->{XCount} > $self->{OCount}) {
    # player X win
    print "Player X wins!";
  } elsif ($self->{XCount} < $self->{OCount}) {
    # player O win
    print "Player O wins!";
  } else {
    # draw
    print "Draw game!";
  }
  print "\n";
}
# start the game
sub startGame {
  my ($self) = @_;
  # no. of round and no. of consecutive pass (0/1/2)
  my $round = my $pass = 0;
  my $invalidMove;
  # print game board
  $self->printBoard();

  # game loop
  do {
    # copy game board
    my @board;
    for my $i (0..7) {
      for my $j (0..7) {
        $board[$i][$j] = $self->{board}[$i][$j];
      }
    }

    # obtain a position from current player
    my @pos = (($self->{turn} eq 'X')? $self->{black} : $self->{white})->nextMove(\@board);
    $invalidMove = 0;

    # check whether valid move
    if ($self->range($pos[0], $pos[1]) && $self->{board}[$pos[0]][$pos[1]] eq '.') {
      my @flip = $self->checkFlip($pos[0], $pos[1]);
      if (@flip) {
        # valid move
        # place the piece
        $self->{board}[$pos[0]][$pos[1]] = $self->{turn};
        # flip opponent's pieces
        foreach my $ele (@flip) {
          $self->{board}[$ele->[0]][$ele->[1]] = $self->{turn};
        }
        # print statement
        print "Player ", $self->{turn}, " places to row ", $pos[0], ", col ", $pos[1], "\n";
        # increment round by 1
        $round++;
        # if previous is pass (ie. pass = 1), set it to zero
        if ($pass) {
          $pass = 0;
        }
      } else {
        # invalid move
        $invalidMove = 1;
      }
    } else {
      # invalid move
      $invalidMove = 1;
    }

    # invalid move
    if ($invalidMove) {
      # pass
      print "Row ", $pos[0], ", col ", $pos[1], " is invalid! Player ", $self->{turn}, " passed!", "\n";
      # increment pass by 1
      $pass++;
    }

    # print game board
    $self->printBoard();

    # alternate player in each round
    $self->{turn} = ($self->{turn} eq 'X')? 'O' : 'X';

  } while ($pass < 2 && $round < 60); # board is full when $round = 60

  # game is end, determine which players win
  $self->endGame();
}

# class player : abstract superclass
package Player;

# constructor : initialize instance variable : player symbol
sub new {
  my ($class, $sym) = @_; # package name and parameter sym
  my $self = {}; # reference to empty hash
  $self->{symbol} = $sym;

  bless $self, $class;
  return $self;
}

# An “abstract” method to be implemented in subclasses
sub nextMove {
}

# class human : subclass of Player
package Human;
@ISA = qw(Player);

# obtain the next move of a human player from user input
sub nextMove {
  my ($self, $board_ref) = @_;
  print "Player ", $self->{symbol}, ", make a move (row col): ";
  my $input = <>;
  chomp ($input);
  my @pos = split(' ', $input);
  return @pos;
}

# class Computer : subclass of Player
package Computer;
@ISA = qw(Player);

# check whether within range
sub range {
  my ($self, $r, $c) = @_;
  return ($r >= 0 && $r <= 7 && $c >=0 && $c <= 7);
}

# check whether can flip opponent's piece, return array containing flippable position
sub checkFlip {
  my ($self, $board_ref, $piece, $r, $c) = @_;
  my @board = @{$board_ref};
  my $opponent = ($piece eq 'X')? 'O' : 'X';
  my @flip; # array containing position of flippable opponent's pieces
  my $x; my $y; my $k; my $pushCount;

  for my $i (1..8) {  # 8 directions
    $pushCount = 0;
    for my $j (1..8) {
        # horizontal
        if ($i == 1) { $x = $r; $y = $c-$j; }
        if ($i == 2) { $x = $r; $y = $c+$j; }
        # vertical
        if ($i == 3) { $x = $r-$j; $y = $c; }
        if ($i == 4) { $x = $r+$j; $y = $c; }
        # left-diagonal
        if ($i == 5) { $x = $r-$j; $y = $c-$j; }
        if ($i == 6) { $x = $r+$j; $y = $c+$j; }
        # right-diagonal
        if ($i == 7) { $x = $r-$j; $y = $c+$j; }
        if ($i == 8) { $x = $r+$j; $y = $c-$j; }

      if ($self->range($x, $y) && ($board[$x][$y] eq $opponent)) {
        # opponent's pieces
        push (@flip, [$x, $y]);  # push the position to array
        $pushCount++;
      } else {
        # out of board or free space
        if (!($self->range($x, $y)) || ($board[$x][$y] eq '.')) {
          for ($k = 0; $k < $pushCount; $k++) {
            pop @flip; # pop array
          }
        }
        last; # break the loop
      }

    }
  }

  return @flip;

}

# Version 2: return a position which minimizes opponent's mobility
sub nextMove {
  my ($self, $board_ref) = @_;
  my @board_tmp = @{$board_ref};
  my $opponent = ($self->{symbol} eq 'X')? 'O' : 'X';
  my @validMove;  # array containing valid moves
  my @pos;  # array to be returned

  # loop for every position
  for my $r (0..7) {
    for my $c (0..7) {
      # only free space can be a valid move
      if ($board_tmp[$r][$c] eq '.') {
        my @flip = $self->checkFlip(\@board_tmp, $self->{symbol}, $r, $c);

        if (@flip) {
          # one of the valid moves
          my $mob = 0;  # count mobility
          # place the piece
          $board_tmp[$r][$c] = $self->{symbol};
          # flip opponent's pieces
          foreach my $ele (@flip) {
            $board_tmp[$ele->[0]][$ele->[1]] = $self->{symbol};
          }
          # count opponent's mobility
          for my $r_opp (0..7) {
            for my $c_opp (0..7) {
              if ($board_tmp[$r_opp][$c_opp] eq '.') {
                my @flip_opp = $self->checkFlip(\@board_tmp, $opponent, $r_opp, $c_opp);

                if (@flip_opp) {
                  $mob++;
                }
              }
            }
          }

          push (@validMove, [$r, $c, $mob]);

          # restore to original board
          # un-place piece
          $board_tmp[$r][$c] = '.';
          # un-flip opponent's pieces
          foreach my $ele (@flip) {
            $board_tmp[$ele->[0]][$ele->[1]] = $opponent;
          }
        }
      }

    }
  }

  # if there is at least one valid move, return the one which has lowest mobility, otherwise return [-1, -1]
  if (@validMove) {
    # among valid moves, find minimum mobility
    my $min = 100; # initialize as some large number
    foreach my $ele (@validMove) {
      if ($ele->[2] < $min) {
        $min = $ele->[2];
      }
    }

    # now, min is the minimum value
    # pick up any one of valid moves which has min mobility
    foreach my $ele (@validMove) {
      if ($ele->[2] == $min) {
        @pos = ($ele->[0], $ele->[1]);
        last;
      }
    }
  }
  else {
    # denote pass
    @pos = (-1, -1);
  }

  # finally, return value
  return @pos;

}

# main program
package main;
my $game = Reversi->new(); # Create object; set up human/computer players
$game->startGame; # Start playing game
