class Tile
  #add_flag, reveal

  attr_accessor :type, :coords, :displayed, :value

  def initialize(type, coords, value = "*")
    @neighbor_transform = {n: [0,1],
                          ne: [1,1],
                          e: [1,0],
                          se: [1,-1],
                          s: [0,-1],
                          sw: [-1,-1],
                          w: [-1,0],
                          nw: [-1,1]}
    @type = type #what it is
    @value = value #what to show
    @coords = coords
    @displayed = false

  end

  def get_neighbors(board)
    neighbors = []
    @neighbor_transform.values.each do |transform|
      row = (self.coords[0] + transform[0])
      column = (self.coords[1] + transform[1])
      neighbors << board[row][column] if on_board?(row, column)
    end
    neighbors
  end

  def on_board?(row, column)
    return false if row < 0 || row > 8
    return false if column < 0 || column > 8
    true
  end

  def get_bombs(neighbors)
    num_bombs = 0
    neighbors.each{|tile| num_bombs += 1 if tile.type == :bomb}
    num_bombs
  end

end
