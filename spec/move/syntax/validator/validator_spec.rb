require './lib/move/syntax/validator/validator'
require './lib/standard/chess_piece'

RSpec.describe Move::Syntax::Validator::PieceTypeParser do

  describe '#parse' do
    subject(:parser) { described_class.new }

    context "when the move is for a pawn" do
      it "returns 'P' to indicate pawn" do
        expect(parser.parse('a3')).to eq(ChessPiece::PA)
      end
    end

    context "when the move is for a rook" do
      it "returns 'R' to indicate rook" do
        expect(parser.parse('Rd4')).to eq(ChessPiece::RO)
      end
    end
  end # #parse

end # Move::Syntax::Validator::PieceTypeParser


RSpec.describe Move::Syntax::Validator do
  
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when the move is for a pawn" do
      it "returns the output of PawnValidator#validate" do
        move = { move: 'a3', color: ChessPiece::WH }
        allow(validator.instance_variable_get(:@parser)).to receive(:parse).and_return(ChessPiece::PA)

        expect(validator.instance_variable_get(:@pawn_validator)).to receive(:validate).with(move)
        validator.validate(move)
      end
    end

    context "when the move is for a piece that is not pawn" do
      it "returns the output of #validate of the appropriate validator class" do
        move = { move: 'Nba3', color: ChessPiece::BL }
        allow(validator.instance_variable_get(:@parser)).to receive(:parse).and_return(ChessPiece::KN)

        expect(validator.instance_variable_get(:@knight_validator)).to receive(:validate).with(move)
        validator.validate(move)
      end
    end
  end

end
