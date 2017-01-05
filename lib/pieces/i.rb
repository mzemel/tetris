module Pieces
  class I < Base
    def initialize(game: game)
      @blocks = 4.times.collect do |i|
        Block.new(x: 0, y: i*Block::HEIGHT, piece: self)
      end
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
      top_block = @blocks.sort{|a, b| a.y <=> b.y}.first
      @blocks = 4.times.collect do |i|
        Block.new(x: top_block.x + i*Block::WIDTH, y: top_block.y, piece: self)
      end
    end

    def redraw_tall
      left_block = @blocks.sort{|a, b| a.x <=> b.x}.first
      @blocks = 4.times.collect do |i|
        Block.new(x: left_block.x, y: left_block.y + i*Block::HEIGHT, piece: self)
      end
    end
  end
end
