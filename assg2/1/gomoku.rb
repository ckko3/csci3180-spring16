=begin
CSCI3180 Principles of Programming Languages
--- Declaration ---
I declare that the assignment here submitted is original except for source material explicitly acknowledged.
I also acknowledge that I am aware of University policy and regulations on honesty in academic work,
and of the disciplinary guidelines and procedures applicable to breaches of such policy and regulations,
as contained in the http://www.cuhk.edu.hk/policy/academichonesty/
Assignment 2
Name: KO Chi Keung
Student ID: 1155033234
Email Addr: ckko3@se.cuhk.edu.hk
=end

# Gomoku

# Gomoku class
class Gomoku

  # initialize class variable
  @@board = Array.new(15) { Array.new(15, '.') } # just a copy of array of game board
  @@turn = 'O' # just a copy of turn

  # initialize all instance variables
  def initialize
    @board = Array.new(15) { Array.new(15, '.') } # 2D array of size 15x15 representing the game board
    @turn = 'O' # Player O takes the first turn
    @win = false
    @round = 0
  end

  # start a new Gomoku game
  def startGame
    # prompt the user to choose the player type for player O and player X
    print "First player is (1) Computer or (2) Human? "
    input = gets.to_i
    if input == 1
      @player1 = Computer.new('O')
      puts "Player O is Computer"
    else
      @player1 = Human.new('O')
      puts "Player O is Human"
    end
    print "Second player is (1) Computer or (2) Human? "
    input = gets.to_i
    if input == 1
      @player2 = Computer.new('X')
      puts "Player X is Computer"
    else
      @player2 = Human.new('X')
      puts "Player X is Human"
    end

    # print the game board
    self.printBoard

    # game loop
    begin
      # obtain a position from current player
      arr = ((@turn == 'O')? @player1 : @player2).nextMove
      puts "Player #{@turn} places to row #{arr[0]}, col #{arr[1]}"
      # update board
      @@board[arr[0]][arr[1]] = @board[arr[0]][arr[1]] = @turn
      @round = @round + 1
      # print the game board
      self.printBoard
      # check whether player wins
      if self.win(arr[0], arr[1])
        # one player wins
        puts "Player #{@turn} wins!"
        @win = true
      else
        # no player wins, alternate player in each round
        @@turn = @turn = (@turn == 'O')? 'X' : 'O'
      end
    end while (!@win && @round < 225)

    if !@win
      # draw game
      puts "Draw game!"
    end

  end

  # print out the game board in the console
  def printBoard
    puts "                       1 1 1 1 1"
    puts "   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4"
    for i in 0...15
      printf("%2d", i)
      for j in 0...15
        printf("%2s", @board[i][j])
      end
      puts
    end
  end

  # check whether free(unoccupied) space or not
  def self.free(r, c)
    return @@board[r][c] == '.'
  end

  # check whether any player win
  def win(r, c)

    for i in 1..4 # horizontal, vertical, left-diagonal, right-diagonal
      count = 0
      for j in 0..1
        for k in 1..4

          case i
          when 1
            arr = [ [r, c-k], [r, c+k] ] # horizontal
          when 2
            arr = [ [r-k, c], [r+k, c] ] # vertical
          when 3
            arr = [ [r-k, c-k], [r+k, c+k] ] # left-diagonal
          when 4
            arr = [ [r-k, c+k], [r+k, c-k] ] # right-diagonal
          end

          if arr[j][0].between?(0, 14) && arr[j][1].between?(0, 14)
            if @board[arr[j][0]][arr[j][1]] == @turn
              count = count + 1
            else
              break
            end
          else
            break
          end

        end
      end

      if count >= 4
        return true
      end

    end

    # reach here, no win
    return false
  end

  # just a copy of win method used by class Computer
  def self.win(r, c)

    for i in 1..4 # horizontal, vertical, left-diagonal, right-diagonal
      count = 0
      for j in 0..1
        for k in 1..4

          case i
          when 1
            arr = [ [r, c-k], [r, c+k] ] # horizontal
          when 2
            arr = [ [r-k, c], [r+k, c] ] # vertical
          when 3
            arr = [ [r-k, c-k], [r+k, c+k] ] # left-diagonal
          when 4
            arr = [ [r-k, c+k], [r+k, c-k] ] # right-diagonal
          end

          if arr[j][0].between?(0, 14) && arr[j][1].between?(0, 14)
            if @@board[arr[j][0]][arr[j][1]] == @@turn
              count = count + 1
            else
              break
            end
          else
            break
          end

        end
      end

      if count >= 4
        return true
      end

    end

    # reach here, no win
    return false
  end

end

# Player class: abstract superclass
class Player

  # initialize player symbol
  def initialize(symbol)
    @symbol = symbol
  end

  # to be implemented in subclasses
  def nextMove
  end

end

# Human class: subclass of Player
class Human < Player
  # obtain the next move of a human player from user input
  def nextMove
    # check if user input is valid or not
    begin
      print "Player #{@symbol}, make a move (row col): "
      arr = gets.chomp.split().map{|i| i.to_i}
      r, c = arr[0], arr[1]
      # check whether 0-14 and free space
      if r.between?(0, 14) && c.between?(0, 14) && Gomoku.free(r, c)
        valid = true
      else
        valid = false
        puts "Invalid input. Try again!"
      end
    end while !valid

    # reach here, input is valid
    return arr
  end
end

# Computer class: subclass of Player
class Computer < Player
  # determine the next move of a computer player
  def nextMove
    sureWin = false
    # check if there is a postion that will win the game
    for i in 0...15
      for j in 0...15
        if Gomoku.win(i, j)
          arr = [i, j]
          sureWin = true
          break
        end
      end
      if sureWin
        break
      end
    end

    # randomly generate a valid move
    if !sureWin
      # ensure it is a valid move
      begin
        r = Random.new.rand(15)
        c = Random.new.rand(15)
      end while !(r.between?(0, 14) && c.between?(0, 14) && Gomoku.free(r, c))
      arr = [r, c]
    end

    return arr
  end
end

# Main Program
Gomoku.new.startGame
