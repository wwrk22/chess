require './lib/move/syntax/validator/validator'
require './lib/standard/chess_piece'


RSpec.describe Move::Syntax::Validator do
  
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when the move is for a pawn" do
      it "returns the output of PawnValidator#validate" do
        move = { move: 'a3', color: ChessPiece::WH }

        expect(validator.instance_variable_get(:@pawn_validator)).to receive(:validate).with(move)
        validator.validate(move, ChessPiece::PA)
      end
    end

    context "when the move is for a piece that is not pawn" do
      it "returns the output of #validate of the appropriate validator class" do
        move = { move: 'Nba3', color: ChessPiece::BL }

        expect(validator.instance_variable_get(:@knight_validator)).to receive(:validate).with(move)
        validator.validate(move, ChessPiece::KN)
      end
    end
  end

end
