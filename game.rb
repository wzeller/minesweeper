class Game
  def initialize
    @board = Board.new
  end

  def play
    puts "Welcome to minesweeper!  Get ready to waste time."

    until @board.all_tiles_revealed?

      @board.render
      puts "Make a move (m), plant a flag (f), or reveal all (r):"
      action = gets.chomp

      move_coords = ""

      unless action == 'r'
        puts "Enter coordinates (0,0 - 8,8):"
        move_coords = gets.chomp
      end


    end



  end

end
