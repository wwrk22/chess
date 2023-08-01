RSpec::Matchers.define :eq_piece do |other_piece|
  match do |piece|
    piece.type == other_piece.type && piece.color == other_piece.color
  end
end
