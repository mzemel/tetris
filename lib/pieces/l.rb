module Pieces
  class L < Base
    def initialize(game: game)
      redraw_north(x: Block::WIDTH, y: Block::HEIGHT)
      @radius = 2
      super(game: game)
    end

    private

    # * = (x, y) of the center (rotational) block
    #    +---+
    #    |   |
    #    *   |
    #    | • |
    # +--+   |
    # |      |
    # +------+
    def redraw_north(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false)
      @blocks << Block.new(x: x, y: y, piece: self, center: true)
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false)
      @blocks << Block.new(x: x - Block::WIDTH, y: y + Block::HEIGHT, piece: self, center: false)
    end

    # +--+
    # |  |
    # +  *-------+
    # |     •    |
    # +----------+
    def redraw_east(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x, y: y, piece: self, center: true)
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x - Block::WIDTH, y: y - Block::HEIGHT, piece: self, center: false)
    end


    # +------+
    # |      |
    # *   +--+
    # | • |
    # |   |
    # |   |
    # +---+
    def redraw_south(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x + Block::WIDTH, y: y - Block::HEIGHT, piece: self, center: false)
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false)
      @blocks << Block.new(x: x, y: y, piece: self, center: true)
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false)
    end

    # +--+
    # |  |
    # +  *-------+
    # |     •    |
    # +----------+
    def redraw_west(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x, y: y, piece: self, center: true)
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x - Block::WIDTH, y: y - Block::HEIGHT, piece: self, center: false)
    end
  end
end
