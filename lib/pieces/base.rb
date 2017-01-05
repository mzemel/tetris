module Pieces
  class Base
    attr_reader :blocks, :game

    ####
    # Game

    def initialize(game: game)
      @game = game
      @state = :active
      @direction = DIRECTIONS.first
    end

    def update
      if Utility.can_move?
        collisions = CollisionDetector.new(
          piece: self,
          other_pieces: game.pieces.reject {|p| p == self}
        ).check
        apply_movements(collisions)
        apply_rotation
        if collisions.include?(:down)
          deactivate
          game.row_clearer.clear_applicable # Move to tetris.rb?
        end
        move_down if active?
      end
    end

    def draw
      blocks.each(&:draw)
    end

    ####
    # Movement

    def apply_movements(collisions)
      move_left if Utility.left_button? && !collisions.include?(:left)
      move_right if Utility.right_button? && !collisions.include?(:right)
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

    def apply_rotation
      # return unless active?
      rotate_clockwise        if Utility.x_button?
      rotate_counterclockwise if Utility.z_button?
      case @direction
      when 'n'
        redraw_north
      when 'e'
        redraw_east
      when 's'
        redraw_south
      when 'w'
        redraw_west
      end
    end

    def rotate_clockwise
      index = DIRECTIONS.index(@direction)
      @direction = DIRECTIONS[index + 1]
    end

    def rotate_counterclockwise
      index = DIRECTIONS.index(@direction)
      @direction = DIRECTIONS[index - 1]
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