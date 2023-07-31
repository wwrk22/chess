require './lib/move/syntax/validator/validator'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe Validator do
  
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when the move is for a pawn" do
      it "returns the output of PawnValidator#validate" do
        move_str = 'a3'
        player_color = white
        validators = validator.instance_variable_get(:@validators)

        expect(validators[pawn]).to receive(:validate).with(move_str, player_color)
        validator.validate(move_str, player_color)
      end
    end

    context "when the move is for a type other than pawn" do
      it "returns the output of #validate of the appropriate validator class" do
        move_str = 'Nba3'
        player_color = black
        validators = validator.instance_variable_get(:@validators)

        expect(validators[knight]).to receive(:validate).with(move_str, player_color)
        validator.validate(move_str, player_color)
      end
    end
  end

  describe '#parse_piece' do
    subject(:validator) { described_class.new }

    context "when the move is for a pawn" do
      it "returns 'P'" do
        move = 'a3'
        expect(validator.parse_piece(move)).to eq(pawn)
      end
    end # context "when the move is for a pawn"

    context "when the move is for a type other than pawn" do
      it "returns the initial designating the type" do
        move = 'R1a5'
        expect(validator.parse_piece(move)).to eq(rook)
      end
    end
  end # describe '#parse_piece'

end
