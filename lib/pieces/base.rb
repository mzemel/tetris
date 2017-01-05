module Pieces
  class Base
    attr_reader :blocks, :game

    ####
    # Game

    def initialize(game: game)
      @game = game
      @state = :active
      @radius ||= 0

      @direction = DIRECTIONS.first
    end

    def update
      rotate # Should feel quicker than movement; has its own rate
      return unless active? && Utility.can_move?

      @collisions = CollisionDetector.new(
        piece: self,
        other_pieces: game.pieces.reject {|p| p == self}
      ).check

      if @collisions.include?(:down)
        deactivate
        game.row_clearer.clear_applicable # Move to tetris.rb?
      else
        apply_movements
        move_down if Utility.down_button? # remove conditional after debugging
      end
    end

    def draw
      blocks.each(&:draw)
    end

    ####
    # Movement

    def apply_movements
      move_left if Utility.left_button? && !@collisions.include?(:left)
      move_right if Utility.right_button? && !@collisions.include?(:right)
    end

    def move_left
      return if left_bound == 0
      blocks.each(&:move_left)
    end

    def move_right
      return if right_bound == Tetris::WIDTH
      blocks.each(&:move_right)
    end

    def move_down
      return if bottom_bound == Tetris::HEIGHT
      blocks.each(&:move_down)
    end

    ####
    # Rotation

    def rotate
      return unless active? && Utility.can_rotate?

      rotate_clockwise        if Utility.x_button?
      rotate_counterclockwise if Utility.z_button?
    end

    def rotate_clockwise
      index = DIRECTIONS.reverse.index(@direction) || 0
      @direction = DIRECTIONS.reverse[index - 1]
      apply_rotation
    end

    def rotate_counterclockwise
      index = DIRECTIONS.index(@direction) || 0
      @direction = DIRECTIONS[index - 1]
      apply_rotation
    end

    def apply_rotation
      center_block = @blocks.detect(&:center)

      x = get_safe_x(point: center_block.x)
      y = get_safe_y(point: center_block.y)

      case @direction
      when 'n'
        redraw_north(x: x, y: y)
      when 'e'
        redraw_east(x: x, y: y)
      when 's'
        redraw_south(x: x, y: y)
      when 'w'
        redraw_west(x: x, y: y)
      end
    end

    def get_safe_x(point: point)
      if point - Block::WIDTH * @radius < 0
        Block::WIDTH * @radius
      elsif point - Block::WIDTH * @radius > 400 # Replace with Tetris::WIDTH
        400 - Block::WIDTH * @radius
      else
        point
      end
    end

    def get_safe_y(point: point)
      if point - Block::HEIGHT * @radius < 0
        Block::HEIGHT * @radius
      elsif point - Block::HEIGHT * @radius > 800 # Replace with Tetris::HEIGHT
        800 - Block::HEIGHT * @radius
      else
        point
      end
    end

    ####
    # State

    def active?
      @state == :active
    end

    def inactive?
      !active?
    end

    def deactivate
      @state = :inactive
    end

    ####
    # Misc

    def remove_block(block)
      @blocks = blocks.reject { |b| b == block }
    end

    def sink(row)
      blocks.select { |b| b.y < row }.each(&:move_down)
    end

    def bottom_bound
      blocks.collect(&:y).max + Block::HEIGHT
    end

    def top_bound
      blocks.collect(&:y).min
    end

    def right_bound
      blocks.collect(&:x).max + Block::WIDTH
    end

    def left_bound
      blocks.collect(&:x).min
    end

    private

    def move
      return Utility.can_move?
      blocks.each { |b| b.y += Utility::PX_PER_MOVE }
    end
  end
end