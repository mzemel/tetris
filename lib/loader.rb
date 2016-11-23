require_relative "background_image"
require_relative "block"
require_relative "utility"
require_relative "pieces"
require_relative "row_clearer"

%w(base i j l o s t z).each do |f|
  require_relative "pieces/#{f}"
end