module Pieces
  class I < Base
    def initialize(game: game)
      @blocks = 4.times.collect do |i|
        Block.new(x: 0, y: i*Block::HEIGHT, piece: self)
      end
      super(game: game)
    end
  end
end
