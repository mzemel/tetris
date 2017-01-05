module Pieces
  class O < Base
    def initialize(game: game)
      @blocks = 2.times.collect do |i|
        2.times.collect do |j|
          Block.new(x: i*Block::WIDTH, y: j*Block::WIDTH, piece: self, center: true)
        end
      end.flatten
      super(game: game)
    end

    private

    def redraw_north(x: x, y: y); end
    def redraw_east(x: x, y: y); end
    def redraw_south(x: x, y: y); end
    def redraw_west(x: x, y: y); end
  end
end