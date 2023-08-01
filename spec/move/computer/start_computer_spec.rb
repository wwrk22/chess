require './lib/move/computer/start_computer'
require './lib/piece/piece_specs'
require './lib/board/board'
require './lib/piece/chess_piece'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe StartComputer do
  describe '#check_start' do
    subject(:computer) { described_class.new }

    it "checks the board to see if the chess piece is on the starting square" do
      board = instance_double(Board)
      start_square = { file: 'a', rank: 1 }
      white_rook = instance_double(ChessPiece)

      allow(board).to receive(:at).with(start_square[:file], start_square[:rank]).and_return(white_rook)

      allow(white_rook).to receive(:type).and_return(rook)
      allow(white_rook).to receive(:color).and_return(white)

      result = computer.check_start(start_square, white_rook, board)
      expect(result).to be_truthy
    end
  end # describe '#check_start'
end
