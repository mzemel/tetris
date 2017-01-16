module Pieces
  class A < Base

    def initialize(game: game)
      redraw_north(x: 0, y: Block::HEIGHT)
      @radius = 2
      super(game: game)
    end

    private

    def redraw_north(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "head_north.png")
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false, asset: "tail_south.png")
    end

    def redraw_east(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "tail_west.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false, asset: "head_east.png")
    end

    def redraw_south(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "tail_north.png")
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false, asset: "head_south.png")
    end

    def redraw_west(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "head_west.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false, asset: "tail_east.png")
    end
  end
end
