module Pieces
  # SHAPES = %w(i j l o s t z).freeze
  SHAPES = %w(i j o l t).freeze
  DIRECTIONS = %w(n e s w).freeze

  def self.random(game: game)
    Object.const_get("Pieces::#{SHAPES.sample.upcase}").new(game: game)
  end
end
