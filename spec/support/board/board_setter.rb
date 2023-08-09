require './lib/board/board_specs'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


module BoardSetter
  include BoardSpecs

  def set_ranks(board, ranks, piece, color)
    ranks.each do |rank|
      files.each do |file|
        board.set({ file: file, rank: rank }, ChessPiece.new(piece, color))
      end
    end
  end
end
