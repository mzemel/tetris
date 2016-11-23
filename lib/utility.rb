class Utility
  PX_PER_MOVE = 50

  module ZIndex
    BG = 0
    BLOCK = 1
  end

  def self.can_move?
    Gosu::milliseconds % move_rate == 0
  end

  def self.left_button?
    Gosu::button_down?(Gosu::KbLeft) || Gosu::button_down?(Gosu::GpLeft)
  end

  def self.right_button?
    Gosu::button_down?(Gosu::KbRight) || Gosu::button_down?(Gosu::GpRight)
  end

  def self.up_button?
    Gosu::button_down?(Gosu::KbUp) || Gosu::button_down?(Gosu::GpUp)
  end

  def self.down_button?
    Gosu::button_down?(Gosu::KbDown) || Gosu::button_down?(Gosu::GpDown)
  end

  def self.z_button?
    Gosu::button_down?(Gosu::KbZ)
  end

  def self.x_button?
    Gosu::button_down?(Gosu::KbX)
  end

  private

  def self.move_rate
    case
    when down_button?
      2
    when left_button? || right_button?
      4
    else
      6
    end
  end
end