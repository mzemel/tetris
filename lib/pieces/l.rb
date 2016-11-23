module Pieces
  class L < Base
    def initialize(game: game)
      @blocks = []
      @blocks << Block.new(x: 0, y: 0, piece: self)
      @blocks << Block.new(x: 0, y: 50, piece: self)
      @blocks << Block.new(x: 0, y: 100, piece: self)
      @blocks << Block.new(x: 50, y: 100, piece: self)
      super(game: game)
    end
  end
end
