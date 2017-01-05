module Pieces
  class J < Base

    def initialize(game: game)
      redraw_north(x: 0, y: Block::HEIGHT)
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
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false, asset: "head_north.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "vertical.png")
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false, asset: "12_3.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y + Block::HEIGHT, piece: self, center: false, asset: "tail_east.png")
    end

    # +--*-------+
    # |     •    |
    # |  +-------+
    # |  |
    # +--+
    def redraw_east(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false, asset: "head_east.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "horizontal.png")
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false, asset: "3_6.png")
      @blocks << Block.new(x: x - Block::WIDTH, y: y + Block::HEIGHT, piece: self, center: false, asset: "tail_south.png")
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
      @blocks << Block.new(x: x - Block::WIDTH, y: y - Block::HEIGHT, piece: self, center: false, asset: "tail_west.png")
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false, asset: "6_9.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "vertical.png")
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false, asset: "head_south.png")
    end

    #         +--+
    #         |  |
    # +---*---+  |
    # |     •    |
    # +----------+
    def redraw_west(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false, asset: "head_west.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "horizontal.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false, asset: "9_12.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y - Block::HEIGHT, piece: self, center: false, asset: "tail_north.png")
    end
  end
end
