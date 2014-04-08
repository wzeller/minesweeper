class Board
  require "./tile.rb"
  require 'debugger'

  # Board Methods
  # won?
  # render
  # update
  # lost?

  def initialize
    @board = make_board

  end

  def make_board
      board = Array.new(9) {Array.new(9)}

      num_bombs = rand(10) + 10

      all_coords = []

      self.each_indices do |xCoord, yCoord|
        all_coords << [xCoord, yCoord]
      end

      @bomb_tiles = []
      @empty_tiles = []

      self.each_indices do |xCoord, yCoord|
        if coordinates_for_bombs.include?([xCoord, yCoord])
          board[xCoord][yCoord] = Tile.new(:bomb, [xCoord, yCoord], "B")
          @bomb_tiles << board[xCoord][yCoord]
        else
          board[xCoord][yCoord] = Tile.new(:empty, [xCoord, yCoord], "_")
          @empty_tiles << board[xCoord][yCoord]
        end
      end

    board
  end

  def lost?
    @bomb_tiles.any? {|tile| tile.displayed == true && tile.value != "F"}
  end

  def won?
    @empty_tiles.all? {|tile| tile.displayed == true}
  end

  def each_indices(&prc)
    (0..8).each do |xCoord|
      (0..8).each do |yCoord|
        prc.call(xCoord, yCoord)
      end
    end
  end

  def reveal(tile)
    return if tile.displayed == true

    tile.displayed = true
    return if tile.type == :bomb

    neighbors = tile.get_neighbors(@board)

    num_bombs = tile.get_bombs(neighbors)
    if  num_bombs == 0
      neighbors.each{ |neighbor| reveal(neighbor) }
    else
      tile.value = num_bombs
    end
  end

  def reveal_all
    self.each_indices do |x, y|
      @board[x][y].displayed = true
    end
  end

  def update(action, move_coords = nil)
    if action == "a"
      self.reveal_all
      return nil
    end

    row = move_coords[0].to_i
    col = move_coords[1].to_i
    tile = @board[row][col]

    if action == "f"
      tile.value = 'F'
      tile.displayed = true
    elsif action == "r"
      reveal(tile)
    end

  end

  def render
    (0..8).each do |xCoord|
      row_array = []
      (0..8).each do |yCoord|

        # p @board[xCoord][yCoord].displayed

        if @board[xCoord][yCoord].displayed
          row_array << @board[xCoord][yCoord].value
        else
          row_array << "*"
        end

      end
      puts row_array.join(" ")
    end

  end

end

