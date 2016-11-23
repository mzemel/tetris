module Pieces
  class S < Base
    def initialize(game: game)
      @blocks = []
      @blocks << Block.new(x: 100, y: 0, piece: self)
      @blocks << Block.new(x: 50, y: 0, piece: self)
      @blocks << Block.new(x: 50, y: 50, piece: self)
      @blocks << Block.new(x: 0, y: 50, piece: self)
      super(game: game)
    end
  end
end
