class Game
  require "./tile"
  require "./board"
  def initialize
    @board = Board.new
  end

  def play
    puts "Welcome to minesweeper!  Get ready to waste time."
    puts

    until @board.won?
      @board.render

      puts "Reveal a square (r), plant a flag (f), or reveal all (a):"
      action = gets.chomp

      move_coords = []

      unless action == 'a'
        puts "Enter coordinates (0,0 - 8,8):"
        move_coords = gets.chomp.delete("()[]").split(",")
      end
      @board.update(action, move_coords)

      system("clear")

      if @board.lost?
        puts "You have selected a bomb"
        break
      end
    end

    if !@board.lost?
      puts "Congratulations!"
    end

    puts "Game Over"
    @board.render
  end
end


game = Game.new
game.play