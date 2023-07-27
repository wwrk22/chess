module PieceSpecs
  WHITE = 'WH'
  BLACK = 'BL'

  PAWN = 'P'
  ROOK = 'R'
  KNIGHT = 'N'
  BISHOP = 'B'
  QUEEN = 'Q'
  KING = 'K'

  private_constant :WHITE, :BLACK
  private_constant :PAWN, :ROOK, :KNIGHT, :BISHOP, :QUEEN, :KING

  def white; WHITE; end
  def black; BLACK; end
  def pawn; PAWN; end
  def rook; ROOK; end
  def knight; KNIGHT; end
  def bishop; BISHOP; end
  def queen; QUEEN; end
  def king; KING; end
end
