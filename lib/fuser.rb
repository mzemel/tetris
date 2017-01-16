class Fuser
  attr_reader :game, :all_blocks

  def initialize(game: game)
    @game = game
    @all_blocks = game.pieces.collect {|p| p.blocks}.flatten
  end

  def fuse!
    game.pieces.reject(&:active?).each do |piece|
      next unless head = piece.blocks.detect { |b| b.asset.match /head/ }
      direction = head.asset.match(/(north|east|south|west)/)[0]
      corresponding_tail = get_corresponding_tail(block: head, direction: direction)
      next unless corresponding_tail
      fuse_blocks(head: head, tail: corresponding_tail)
      Score.add(50)
    end
  end

  def get_corresponding_tail(block: block, direction: direction)
    case direction
    when "north"
      all_blocks.detect do |b|
        (b.x == block.x && b.y == block.y - Block::HEIGHT && b.asset.match(/tail_(east|south|west)/)) ||
        (b.x == block.x + Block::WIDTH && b.y == block.y && b.asset.match(/tail_(east|south|west)/)) ||
        (b.x == block.x - Block::WIDTH && b.y == block.y && b.asset.match(/tail_(east|south|west)/))
      end
    when "east"
      all_blocks.detect do |b|
        (b.x == block.x && b.y == block.y - Block::HEIGHT && b.asset.match(/tail_(north|south|west)/)) ||
        (b.x == block.x && b.y == block.y + Block::HEIGHT && b.asset.match(/tail_(north|south|west)/)) ||
        (b.x == block.x - Block::WIDTH && b.y == block.y && b.asset.match(/tail_(north|south|west)/))
      end
    when "south"
      all_blocks.detect do |b|
        (b.x == block.x && b.y == block.y + Block::HEIGHT && b.asset.match(/tail_(east|north|west)/)) ||
        (b.x == block.x + Block::WIDTH && b.y == block.y && b.asset.match(/tail_(east|north|west)/)) ||
        (b.x == block.x - Block::WIDTH && b.y == block.y && b.asset.match(/tail_(east|north|west)/))
      end
    when "west"
      all_blocks.detect { |b| b.x == block.x - Block::WIDTH && b.y == block.y && b.asset.match(/tail_(east|north|south)/) }
    end
  end

  def fuse_blocks(head: head, tail: tail)
    head_direction = head.asset.match(/(north|east|south|west)/)[0]
    tail_direction = tail.asset.match(/(north|east|south|west)/)[0]
    case

    # SOUTH HEAD
    when head_direction == "south" && tail_direction == "north"
      head.asset = "vertical.png"
      tail.asset = "vertical.png"
    when head_direction == "south" && tail_direction == "east" && right_of?(head, tail)
      head.asset = "9_12.png"
      tail.asset = "horizontal.png"
    when head_direction == "south" && tail_direction == "east" && above?(head, tail)
      head.asset = "vertical.png"
      tail.asset = "9_12.png"
    when head_direction == "south" && tail_direction == "west" && left_of?(head, tail)
      head.asset = "12_3.png"
      tail.asset = "horizontal.png"
    when head_direction == "south" && tail_direction == "west" && above?(head, tail)
      head.asset = "vertical.png"
      tail.asset = "12_3.png"

    # NORTH HEAD
    when head_direction == "north" && tail_direction == "south"
      head.asset = "vertical.png"
      tail.asset = "vertical.png"
    when head_direction == "north" && tail_direction == "east" && right_of?(head, tail)
      head.asset = "6_9.png"
      tail.asset = "horizontal.png"
    when head_direction == "north" && tail_direction == "east" && below?(head, tail)
      head.asset = "vertical.png"
      tail.asset = "3_6.png"
    when head_direction == "north" && tail_direction == "west" && left_of?(head, tail)
      head.asset = "3_6.png"
      tail.asset = "horizontal.png"
    when head_direction == "north" && tail_direction == "west" && below?(head, tail)
      head.asset = "vertical.png"
      tail.asset = "6_9.png"

    # EAST HEAD
    when head_direction == "east" && tail_direction == "west"
      head.asset = "horizontal.png"
      tail.asset = "horizontal.png"
    when head_direction == "east" && tail_direction == "north" && left_of?(head, tail)
      head.asset = "horizontal.png"
      tail.asset = "6_9.png"
    when head_direction == "east" && tail_direction == "north" && above?(head, tail)
      head.asset = "6_9.png"
      tail.asset = "vertical.png"
    when head_direction == "east" && tail_direction == "south" && right_of?(head, tail)
      head.asset = "3_6.png"
      tail.asset = "horizontal.png"
    when head_direction == "east" && tail_direction == "south" && below?(head, tail)
      head.asset = "vertical.png"
      tail.asset = "6_9.png"

    # WEST HEAD
    when head_direction == "west" && tail_direction == "east"
      head.asset = "horizontal.png"
      tail.asset = "horizontal.png"
    when head_direction == "west" && tail_direction == "east" && right_of?(head, tail)
      head.asset = "6_9.png"
      tail.asset = "horizontal.png"
    when head_direction == "west" && tail_direction == "east" && below?(head, tail)
      head.asset = "vertical.png"
      tail.asset = "3_6.png"
    when head_direction == "west" && tail_direction == "west" && left_of?(head, tail)
      head.asset = "3_6.png"
      tail.asset = "horizontal.png"
    when head_direction == "west" && tail_direction == "west" && below?(head, tail)
      head.asset = "vertical.png"
      tail.asset = "6_9.png"
    end
  end

  def right_of?(a, b)
    a.y == b.y && a.x == b.x + Block::WIDTH
  end

  def left_of?(a,b)
    a.y == b.y && a.x == b.x - Block::WIDTH
  end

  def above?(a, b)
    a.x == b.x && a.y == b.y - Block::HEIGHT
  end

  def below?(a, b)
    a.x == b.x && a.y == b.y + Block::HEIGHT
  end
end