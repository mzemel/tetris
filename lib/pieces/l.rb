module Pieces
  class L < Base
    def initialize(game: game)
      @blocks = []
      @blocks << Block.new(x: 0, y: 0, piece: self, center: false)
      @blocks << Block.new(x: 0, y: 50, piece: self, center: true)
      @blocks << Block.new(x: 0, y: 100, piece: self, center: false)
      @blocks << Block.new(x: 50, y: 100, piece: self, center: false)
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
    def redraw_north
      center_block = @blocks.detect(&:center)

      x = get_safe_x(point: center_block.x)
      y = get_safe_y(point: center_block.y)

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
    def redraw_east
      center_block = @blocks.detect(&:center)

      x = get_safe_x(point: center_block.x)
      y = get_safe_y(point: center_block.y)

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
    def redraw_south
      center_block = @blocks.detect(&:center)

      x = get_safe_x(point: center_block.x)
      y = get_safe_y(point: center_block.y)

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
    def redraw_west
      center_block = @blocks.detect(&:center)

      x = get_safe_x(point: center_block.x)
      y = get_safe_y(point: center_block.y)

      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x, y: y, piece: self, center: true)
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false)
      @blocks << Block.new(x: x - Block::WIDTH, y: y - Block::HEIGHT, piece: self, center: false)
    end
  end
end
