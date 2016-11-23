module Pieces
  class O < Base
    def initialize(game: game)
      @blocks = 2.times.collect do |i|
        2.times.collect do |j|
          Block.new(x: i*Block::WIDTH, y: j*Block::WIDTH, piece: self)
        end
      end.flatten
      super(game: game)
    end
  end
end