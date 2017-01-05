module Pieces
  class I < Base

    def initialize(game: game)
      redraw_north(x: Block::WIDTH, y: 0)
      @radius = 3
      super(game: game)
    end

    private

    def redraw_north(x: x, y: y)
      @blocks = 4.times.collect do |i|
        center = i == 1
        Block.new(x: x - Block::WIDTH + i*Block::WIDTH, y: y, piece: self, center: center)
      end
    end

    def redraw_east(x: x, y: y)
      @blocks = 4.times.collect do |i|
        center = i == 1
        Block.new(x: x, y: y - Block::HEIGHT + i*Block::HEIGHT, piece: self, center: center)
      end
    end

    def redraw_south(x: x, y: y)
      redraw_north(x: x, y: y)
    end

    def redraw_west(x: x, y: y)
      redraw_east(x: x, y: y)
    end
  end
end
