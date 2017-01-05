module Pieces
  class I < Base

    def initialize(game: game)
      @blocks = 4.times.collect do |i|
        center = i == 2
        Block.new(x: 0, y: i*Block::HEIGHT, piece: self, center: center)
      end
      @radius = 4
      super(game: game)
    end

    private

    def redraw_north(x: x, y: y)
      @blocks = 4.times.collect do |i|
        center = i == 2
        Block.new(x: x + i*Block::WIDTH, y: y, piece: self, center: center)
      end
    end

    def redraw_east(x: x, y: y)
      @blocks = 4.times.collect do |i|
        center = i == 2
        Block.new(x: x, y: y + i*Block::HEIGHT, piece: self, center: center)
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
