module Pieces
  class Base
    attr_reader :blocks, :game

    ####
    # Game

    def initialize(game: game)
      @game = game
      @state = :active
    end

    def update
      move_left if Utility.left_button?
      move_right if Utility.right_button?
      rotate_clockwise if Utility.x_button?
      rotate_counterclockwise if Utility.z_button?
      check_collisions
      move_down if active?
    end

    def draw
      blocks.each(&:draw)
    end

    ####
    # Movement

    def move_left
      return if left_bound == 0 || !Utility.can_move?
      blocks.each(&:move_left)
    end

    def move_right
      return if right_bound == Tetris::WIDTH || !Utility.can_move?
      blocks.each(&:move_right)
    end

    def move_down
      return if bottom_bound == Tetris::HEIGHT || !Utility.can_move?
      blocks.each(&:move_down)
    end

    def rotate_clockwise; end
    def rotate_counterclockwise; end

    def check_collisions
      if bottom_bound == Tetris::HEIGHT
        deactivate
        game.row_clearer.clear
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

    private

    def move
      return Utility.can_move?
      blocks.each { |b| b.y += Utility::PX_PER_MOVE }
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
  end
end