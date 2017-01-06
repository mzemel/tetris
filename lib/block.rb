class Block
  attr_accessor :x, :y, :center
  attr_reader :image, :piece, :asset

  HEIGHT = 50
  WIDTH = 50

  def initialize(x: x, y: y, piece: piece, center: center, asset: asset)
    @asset = asset
    @image = Gosu::Image.new("assets/#{asset}")
    @x = x
    @y = y
    @piece = piece
    @center = center
  end

  def move_left
    @x -= Utility::PX_PER_MOVE
  end

  def move_right
    @x += Utility::PX_PER_MOVE
  end

  def move_down
    @y += Utility::PX_PER_MOVE
  end

  def draw
    image.draw(x, y, Utility::ZIndex::BLOCK)
  end

  def destroy
    piece.remove_block(self)
  end
end