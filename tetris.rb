require 'gosu'
require 'pry'
require_relative 'lib/loader'

class Tetris < Gosu::Window
  WIDTH = 400
  HEIGHT = 800

  attr_reader :background_image, :pieces, :row_clearer, :game_over

  def initialize
    super WIDTH, HEIGHT
    self.caption = "Tetris"

    @background_image = BackgroundImage.new
    @pieces = []
    @row_clearer = RowClearer.new(game: self)
    @game_over = false
  end

  def update
    if game_over
      handle_game_over
    else
      if pieces.all?(&:inactive?)
        @pieces << Pieces.random(game: self)
      end
      pieces.select(&:active?).each(&:update)
      check_game_over
    end
  end

  def draw
    background_image.draw
    pieces.each(&:draw)
  end

  private

  def check_game_over
    @game_over = pieces.select(&:inactive?).any? {|p| p.top_bound == 0}
  end

  def handle_game_over
    puts "Game Over!"
  end
end

window = Tetris.new
window.show