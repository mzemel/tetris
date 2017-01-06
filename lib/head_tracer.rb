class HeadTracer
  attr_reader :game, :all_blocks

  def initialize(game: game)
    @game       = game
    @all_blocks = game.pieces.collect {|p| p.blocks}.flatten
  end

  def trace!
    # Get all heads & dispatch each to #trace_head
    game.pieces.reject(&:active?).each do |piece|
      next unless head = piece.blocks.detect { |b| b.asset.match /head/ }
      result = trace_from_start(head, 1)
      puts "Result: #{result.inspect}"
    end
  end

  def trace_from_start(start, count = 0, direction = nil)
    direction ||= start.asset.match(/(north|east|south|west)/)[0]
    next_block = get_next_block(start, direction)

    # No next block
    return [:incomplete, count] unless next_block

    # Next block is a line
    if next_block.asset.match(/vertical/) && %w(north south).include?(direction) ||
        next_block.asset.match(/horizontal/) && %w(east west).include?(direction)
      return trace_from_start(next_block, count + 1, direction) # does this infinite loop?
    end

    # Next block is a turn
    case
    when direction == 'north' && next_block.asset == '12_3.png'
      return trace_from_start(next_block, count + 1, 'west')
    when direction == 'north' && next_block.asset == '9_12.png'
      return trace_from_start(next_block, count + 1, 'east')
    when direction == 'east' && next_block.asset == '12_3.png'
      return trace_from_start(next_block, count + 1, 'south')
    when direction == 'east' && next_block.asset == '3_6.png'
      return trace_from_start(next_block, count + 1, 'north')
    when direction == 'south' && next_block.asset == '3_6.png'
      return trace_from_start(next_block, count + 1, 'west')
    when direction == 'south' && next_block.asset == '6_9.png'
      return trace_from_start(next_block, count + 1, 'east')
    when direction == 'west' && next_block.asset == '6_9.png'
      return trace_from_start(next_block, count + 1, 'north')
    when direction == 'west' && next_block.asset == '9_12.png'
      return trace_from_start(next_block, count + 1, 'south')
    end

    # Next block is a head or tail
    if next_block.asset.match(/south/) && direction == 'north' ||
      next_block.asset.match(/west/)   && direction == 'east'  ||
      next_block.asset.match(/north/)  && direction == 'south' ||
      next_block.asset.match(/east/)   && direction == 'west'
        return [:complete, count + 1]
    end

    # Next block is not compatible
    return [:incomplete, count]
  end

  def get_next_block(start, direction)
    case direction
    when 'north'
      @all_blocks.detect { |b| b.x == start.x && b.y == start.y + Block::HEIGHT }
    when 'east'
      @all_blocks.detect { |b| b.x == start.x - Block::WIDTH && b.y == start.y }
    when 'south'
      @all_blocks.detect { |b| b.x == start.x && b.y == start.y - Block::HEIGHT }
    when 'west'
      @all_blocks.detect { |b| b.x == start.x + Block::WIDTH && b.y == start.y }
    end
  end
end