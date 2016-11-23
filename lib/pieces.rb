module Pieces
  SHAPES = %w(i j l o s t z).freeze

  def self.random(game: game)
    Object.const_get("Pieces::#{SHAPES.sample.upcase}").new(game: game)
  end
end
