module Pieces
  class J < Base

    def initialize(game: game)
      @blocks = []
      @blocks << Block.new(x: 0, y: 0, piece: self, center: false)
      @blocks << Block.new(x: 50, y: 0, piece: self, center: false)
      @blocks << Block.new(x: 50, y: 50, piece: self, center: true)
      @blocks << Block.new(x: 50, y: 100, piece: self, center: false)
      @radius = 2
      super(game: game)
    end

    private

    # * = (x, y) of the center (rotational) block
    # +---+
    # |   |
    # *   |
    # | • |
    # |   +--+
    # |      |
    # +------+
    def redraw_north(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false)
      @blocks << Block.new(x: x, y: y, piece: self, center: true)
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false)
      @blocks << Block.new(x: x + Block::WIDTH, y: y + Block::HEIGHT, piece: self, center: false)
    end

    # +--*-------+
    # |     •    |
    # |  +-------+
    # |  |
    # +--+
    def redraw_east(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x, y: y, piece: self, center: true)
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x - Block::WIDTH, y: y + Block::HEIGHT, piece: self, center: false)
    end


    # +------+
    # |      |
    # +--*   |
    #    | • |
    #    |   |
    #    |   |
    #    +---+
    def redraw_south(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y - Block::HEIGHT, piece: self, center: false)
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false)
      @blocks << Block.new(x: x, y: y, piece: self, center: true)
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false)
    end

    #         +--+
    #         |  |
    # +---*---+  |
    # |     •    |
    # +----------+
    def redraw_west(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x, y: y, piece: self, center: true)
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x + Block::WIDTH, y: y - Block::HEIGHT, piece: self, center: false)
    end
  end
end
