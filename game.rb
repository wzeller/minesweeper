class Game
  require "./tile"
  require "./board"
  require 'yaml'
  def initialize
    @board = Board.new  
  end

  def play
    puts "Welcome to minesweeper!  Get ready to waste time."
    puts "Would you like to load a game? (y/n)"
    load = gets.chomp
    if load == "y"
      puts "Filename:"
      filename = gets.chomp
      YAML::load(filename) 
      @board = YAML.load_file(filename)
    end

    until @board.won?
      @board.render
      
      #add flow for save
      puts "Reveal a square (r), plant a flag (f), save game(s) or reveal all (a):"
      action = gets.chomp

      move_coords = []

      unless action == 'a' || action == 's'
        puts "Enter coordinates (0,0 - 8,8):"
        move_coords = gets.chomp.delete("()[],").split("")
      end

      @board.update(action, move_coords)

      if action == 's'
        puts "See you next time."
        break
      end

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