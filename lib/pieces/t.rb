module Pieces
  class T < Base
    def initialize(game: game)
      redraw_north(x: Block::WIDTH, y: 0)
      @radius = 2
      super(game: game)
    end

    private

    # * = (x, y) of the center (rotational) block
    # +--*------+
    # |    •    |
    # +--+   +--+
    #    |   |
    #    +---+
    def redraw_north(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false, asset: "block.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "3_6.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false, asset: "head_east.png")
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false, asset: "tail_south.png")
    end

    # +---+
    # |   |
    # *   +--+
    # | •    |
    # |   +--+
    # |   |
    # +---+
    def redraw_east(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false, asset: "head_north.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "12_3.png")
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false, asset: "block.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false, asset: "tail_east.png")
    end


    #    +---+
    #    |   |
    # +--*   +--+
    # |    •    |
    # +---------+
    def redraw_south(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false, asset: "head_west.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "9_12.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false, asset: "block.png")
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false, asset: "tail_north.png")
    end

    #    +---+
    #    |   |
    # +--*   |
    # |    • |
    # +--+   |
    #    |   |
    #    +---+
    def redraw_west(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false, asset: "block.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "6_9.png")
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false, asset: "head_south.png")
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false, asset: "tail_west.png")
    end
  end
end
