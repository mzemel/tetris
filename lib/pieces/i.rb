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

    def redraw_north
      redraw_tall
    end

    def redraw_east
      redraw_flat
    end

    def redraw_south
      redraw_tall
    end

    def redraw_west
      redraw_flat
    end

    def redraw_flat
      center_block = @blocks.detect(&:center)

      x = get_safe_x(point: center_block.x)
      y = get_safe_y(point: center_block.y)

      @blocks = 4.times.collect do |i|
        center = i == 2
        Block.new(x: x + i*Block::WIDTH, y: y, piece: self, center: center)
      end
    end

    def redraw_tall
      center_block = @blocks.detect(&:center)

      x = get_safe_x(point: center_block.x)
      y = get_safe_y(point: center_block.y)

      @blocks = 4.times.collect do |i|
        center = i == 2
        Block.new(x: x, y: y + i*Block::HEIGHT, piece: self, center: center)
      end
    end
  end
end
