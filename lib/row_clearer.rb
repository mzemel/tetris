require 'set'

class RowClearer
  attr_reader :pieces

  def initialize(game: game)
    @pieces = game.pieces
  end

  def clear!
    clear_rows(clearable_rows)
  end

  private

  def clear_rows(rows)
    rows.each do |row|
      blocks_in_row(row).each { |block| block.destroy }
      all_pieces_above_row(row).each { |piece| piece.sink(row) }
    end
  end

  def clearable_rows
    all_rows.select do |row|
      Set.new(blocks_in_row(row).map(&:x)) == all_columns
    end
  end

  def all_rows
    @all_rows ||= (Tetris::HEIGHT / Block::HEIGHT).times.collect { |n| n*50 }
  end

  def all_columns
    @all_columns ||= Set.new(
      (Tetris::WIDTH / Block::WIDTH).times.collect { |n| n*50 }
    )
  end

  def all_blocks
    pieces.collect(&:blocks).flatten
  end

  def blocks_in_row(row)
    all_blocks.select { |block| block.y == row }
  end

  def all_pieces_above_row(row)
    all_blocks
      .select { |block| block.y < row }
      .map(&:piece)
      .uniq
  end
end