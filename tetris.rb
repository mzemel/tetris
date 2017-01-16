require 'gosu'
require 'pry'
require_relative 'lib/loader'

class Tetris < Gosu::Window
  WIDTH = 400
  HEIGHT = 800

  attr_reader :background_image, :pieces, :game_over

  def initialize
    super WIDTH, HEIGHT
    self.caption = "Tetris"

    @background_image = BackgroundImage.new
    @pieces = []
    @game_over = false
    @score_boxes = 2.times.collect { Gosu::Font.new(20) }
  end

  def update
    Utility.add_counter
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
    display_scores
  end

  private

  def check_game_over
    @game_over = pieces.select(&:inactive?).any? {|p| p.top_bound == 0}
  end

  def handle_game_over
    puts "Game Over!"
  end

  def display_scores
    @score_boxes.first.draw(
      "Score: #{Score.score}",
      Tetris::WIDTH - 2*Block::WIDTH,
      Block::HEIGHT - 10,
      1,
      1.0,
      1.0,
      0xff_ffff00)
    @score_boxes.last.draw(
      "Longest: #{Score.longest}",
      Tetris::WIDTH - 2*Block::WIDTH,
      Block::HEIGHT + 10,
      1,
      1.0,
      1.0,
      0xff_ffff00)
  end
end

window = Tetris.new
window.show