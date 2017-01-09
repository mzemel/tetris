class CircuitTracer
  attr_reader :game, :all_blocks

  def initialize(game: game)
    @game       = game
    @all_blocks = game.pieces.collect {|p| p.blocks}.flatten
  end

  def trace!
    # Get all heads & dispatch each to #trace_head
    game.pieces.reject(&:active?).each do |piece|
      next unless head = piece.blocks.detect { |b| b.asset.match /head/ }
      result = trace_recursively(current: head, count: 1, direction: nil, original: 'head')
      puts result[0]
      handle_complete(result) if result[0] != 'Incomplete'
    end
  end

  def trace_recursively(current: current, count: 0, direction: nil, original: 'head')
    direction ||= current.asset.match(/(north|east|south|west)/)[0]
    next_block = get_next_block(current, direction)

    # No next block
    return ['Incomplete', count] unless next_block

    # Next block is a compatible line
    if next_block.asset.match(/vertical/) && %w(north south).include?(direction) ||
        next_block.asset.match(/horizontal/) && %w(east west).include?(direction)
      return trace_recursively(current: next_block, count: count + 1, direction: direction, original: original)
    end

    # Next block is a compatible turn
    case
    when direction == 'north' && next_block.asset == '12_3.png'
      return trace_recursively(current: next_block, count: count + 1, direction: 'west', original: original)
    when direction == 'north' && next_block.asset == '9_12.png'
      return trace_recursively(current: next_block, count: count + 1, direction: 'east', original: original)
    when direction == 'east' && next_block.asset == '12_3.png'
      return trace_recursively(current: next_block, count: count + 1, direction: 'south', original: original)
    when direction == 'east' && next_block.asset == '3_6.png'
      return trace_recursively(current: next_block, count: count + 1, direction: 'north', original: original)
    when direction == 'south' && next_block.asset == '3_6.png'
      return trace_recursively(current: next_block, count: count + 1, direction: 'west', original: original)
    when direction == 'south' && next_block.asset == '6_9.png'
      return trace_recursively(current: next_block, count: count + 1, direction: 'east', original: original)
    when direction == 'west' && next_block.asset == '6_9.png'
      return trace_recursively(current: next_block, count: count + 1, direction: 'north', original: original)
    when direction == 'west' && next_block.asset == '9_12.png'
      return trace_recursively(current: next_block, count: count + 1, direction: 'south', original: original)
    end

    # Next block is a compatible head or tail
    if next_block.asset.match(/south/) && direction == 'north' ||
      next_block.asset.match(/west/)   && direction == 'east'  ||
      next_block.asset.match(/north/)  && direction == 'south' ||
      next_block.asset.match(/east/)   && direction == 'west'
        circuit_type = get_circuit_type(next_block.asset.match(/(head|tail)/)[0], original)
        return [circuit_type, count + 1]
    end 

    # Next block is not compatible
    return ['Incomplete', count]
  end

  def get_circuit_type(current, original)
    case
    when current == 'head' && original == 'head'
      'Double Head'
    when current == 'tail' && original == 'tail'
      'Double Tail'
    else
      'Normal'
    end
  end

  def get_next_block(current, direction)
    case direction
    when 'north'
      @all_blocks.detect { |b| b.x == current.x && b.y == current.y + Block::HEIGHT }
    when 'east'
      @all_blocks.detect { |b| b.x == current.x - Block::WIDTH && b.y == current.y }
    when 'south'
      @all_blocks.detect { |b| b.x == current.x && b.y == current.y - Block::HEIGHT }
    when 'west'
      @all_blocks.detect { |b| b.x == current.x + Block::WIDTH && b.y == current.y }
    end
  end

  def handle_complete(result)
    # Increase score
    # Display type of circuit
    # Clear circuit
    # Call RowClearer to clear blocks and sink pieces above
  end
end