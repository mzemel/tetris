require 'set'

class RowClearer
  attr_reader :pieces

  def initialize(game: game)
    @pieces = game.pieces
  end

  def clear_applicable
    clear_rows(clearable_rows)
  end

  private

  def clear_rows(rows)
    rows.each do |row|
      blocks_for_row(row).each do |block|
        block.destroy
        block.piece.sink(row)
      end
    end
  end

  def clearable_rows
    all_rows.select do |row|
      true if Set.new(blocks_for_row(row).map(&:x)) == all_columns_set
    end
  end

  def all_rows
    @all_rows ||= (Tetris::HEIGHT / Block::HEIGHT).times.collect { |n| n*50 }
  end

  def all_columns_set
    @all_columns_set ||= Set.new(
      (Tetris::WIDTH / Block::WIDTH).times.collect { |n| n*50 }
    )
  end

  def all_blocks
    pieces.collect(&:blocks).flatten
  end

  def blocks_for_row(row)
    all_blocks.select { |b| b.y == row }
  end
end