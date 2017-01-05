module Pieces
  class I < Base

    def initialize(game: game)
      redraw_north(x: 0, y: Block::HEIGHT)
      @radius = 3
      super(game: game)
    end

    private

    def redraw_north(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false, asset: "head_north.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "vertical.png")
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false, asset: "vertical.png")
      @blocks << Block.new(x: x, y: y + 2*Block::HEIGHT, piece: self, center: false, asset: "tail_south.png")
    end

    def redraw_east(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false, asset: "tail_west.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "horizontal.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false, asset: "horizontal.png")
      @blocks << Block.new(x: x + 2*Block::WIDTH, y: y, piece: self, center: false, asset: "head_east.png")
    end

    def redraw_south(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x, y: y - Block::HEIGHT, piece: self, center: false, asset: "tail_north.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "vertical.png")
      @blocks << Block.new(x: x, y: y + Block::HEIGHT, piece: self, center: false, asset: "vertical.png")
      @blocks << Block.new(x: x, y: y + 2*Block::HEIGHT, piece: self, center: false, asset: "head_south.png")
    end

    def redraw_west(x: x, y: y)
      @blocks = []
      @blocks << Block.new(x: x - Block::WIDTH, y: y, piece: self, center: false, asset: "head_west.png")
      @blocks << Block.new(x: x, y: y, piece: self, center: true, asset: "horizontal.png")
      @blocks << Block.new(x: x + Block::WIDTH, y: y, piece: self, center: false, asset: "horizontal.png")
      @blocks << Block.new(x: x + 2*Block::WIDTH, y: y, piece: self, center: false, asset: "tail_east.png")
    end
  end
end
