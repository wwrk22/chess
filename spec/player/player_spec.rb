require 'support/matchers/chess_piece'
require './lib/player/player'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'
require './lib/move/move'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe Player do
  describe '#prompt_move' do
    let!(:valid_move) { 'a3' }
    let!(:color) { white }
    subject(:player) { described_class.new('player', color) }

    it "validates the syntax of player input" do
      allow(player).to receive(:gets).and_return(valid_move)
      validator = player.instance_variable_get(:@validator)

      expect(validator).to receive(:validate).with(valid_move, color)
      player.prompt_move
    end

    it "returns a Move object with the `str` and `color` attributes set" do
      allow(player).to receive(:gets).and_return(valid_move)

      expected = ChessPiece.new(pawn, white)

      result = player.prompt_move

      expect(result).to eq_piece(expected)
    end
  end # describe '#prompt_move'
end
