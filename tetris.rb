require 'gosu'
require 'pry'
require_relative 'lib/loader'

class Tetris < Gosu::Window
  WIDTH = 400
  HEIGHT = 800

  attr_reader :background_image, :pieces, :row_clearer

  def initialize
    super WIDTH, HEIGHT
    self.caption = "Tetris"

    @background_image = BackgroundImage.new
    @pieces = []
    @row_clearer = RowClearer.new(game: self)
  end

  def update
    if pieces.all?(&:inactive?)
      @pieces << Pieces.random(game: self)
    end
    pieces.select(&:active?).each(&:update)
  end

  def draw
    background_image.draw
    pieces.each(&:draw)
  end
end

window = Tetris.new
window.show