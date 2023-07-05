require './lib/move/syntax/validator/validator'
require './lib/standard/chess_piece'

RSpec.describe Move::Syntax::Validator::PieceTypeParser do

  describe '#parse' do
    subject(:parser) { described_class.new }

    context "when the move is for a pawn" do
      it "returns 'P' to indicate pawn" do
        move = { move: 'a3', color: ChessPiece::WH }
        expect(parser.parse(move)).to eq(ChessPiece::PA)
      end
    end

    context "when the move is for a rook" do
      it "returns 'R' to indicate rook" do
        move = { move: 'Rd4', color: ChessPiece::WH }
        expect(parser.parse(move)).to eq(ChessPiece::RO)
      end
    end
  end # #parse

end # Move::Syntax::Validator::PieceTypeParser


RSpec.describe Move::Syntax::Validator do
  
  describe '' do



  end

end
