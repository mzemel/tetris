module Pieces
  class I < Base
    def initialize(game: game)
      @blocks = 4.times.collect do |i|
        Block.new(x: 0, y: i*Block::HEIGHT, piece: self)
      end

      # Farthest x or y can be to rotate and keep all blocks on the board
      @safe_x_pos = Object.const_get("#{game.class}::WIDTH") - 4 * Block::WIDTH
      @safe_y_pos = Object.const_get("#{game.class}::HEIGHT") - 4 * Block::HEIGHT

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
      x_pos = if top_block.x <= @safe_x_pos
          top_block.x
        else
          @safe_x_pos
        end

      @blocks = 4.times.collect do |i|
        Block.new(x: x_pos+ i*Block::WIDTH, y: top_block.y, piece: self)
      end
    end

    def redraw_tall
      left_block = @blocks.sort{|a, b| a.x <=> b.x}.first
      y_pos = if left_block.y <= @safe_y_pos
          left_block.y
        else
          @safe_y_pos
        end
      @blocks = 4.times.collect do |i|
        Block.new(x: left_block.x, y: y_pos + i*Block::HEIGHT, piece: self)
      end
    end
  end
end
