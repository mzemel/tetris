# Takes a piece and checks if it's next to any block

# +---+   +---+
# |   |   |   |
# |   +---|   |
# |       |   |
# |   +---|   |
# |   |   |   |
# +---+   +---+

class CollisionDetector
  attr_reader :piece, :other_pieces

  def initialize(piece: piece, other_pieces: other_pieces)
    @piece = piece
    @other_pieces = other_pieces
  end

  def check
    collisions = []
    collisions << :left  if detect_left_collision
    collisions << :right if detect_right_collision
    collisions << :down  if detect_down_collision || piece_on_ground
    collisions
  end

  private

  def detect_left_collision
    piece.blocks.any? do |block|
      other_blocks.any? do |other_block|
        block.y == other_block.y && block.x == other_block.x + Block::WIDTH
      end
    end
  end

  def detect_right_collision
    piece.blocks.any? do |block|
      other_blocks.any? do |other_block|
        block.y == other_block.y && block.x + Block::WIDTH == other_block.x
      end
    end
  end

  def detect_down_collision
    piece.blocks.any? do |block|
      other_blocks.any? do |other_block|
        block.x == other_block.x && block.y + Block::HEIGHT == other_block.y
      end
    end
  end

  def piece_on_ground
    piece.bottom_bound == Tetris::HEIGHT
  end

  def other_blocks
    @other_blocks ||= other_pieces.collect(&:blocks).flatten
  end
end