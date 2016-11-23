class BackgroundImage
  attr_reader :image

  def initialize
    @image = Gosu::Image.new("assets/background_image.png")
  end

  def update
  end

  def draw
    image.draw(0, 0, Utility::ZIndex::BG)
  end
end