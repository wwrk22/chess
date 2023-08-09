require './lib/board/board'
require './lib/move/computer/knight_start_computer'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe KnightStartComputer do
  describe '#compute_start' do

    let!(:move) { instance_double(Move) }
    let!(:board) { instance_double(Board) }

  end # describe '#compute_start'


  describe '#all_possible_starts' do
    subject(:computer) { described_class.new }

    it "filters out starts that have invalid coordinates" do
      target_sq = { file: 'a', rank: 1 }
      expected = [{ file: 'b', rank: 3 }, { file: 'c', rank: 2 }]

      filtered_starts = computer.all_possible_starts(target_sq)

      expect(filtered_starts).to eq(expected)
    end
  end # describe '#all_possible_starts'


  describe '#find_knight' do
    subject(:computer) { described_class.new }

    it "returns a starting square if there is only one such that the knight is on" do
      white_knight = ChessPiece.new(knight, white)
      empty_sq = { file: 'c', rank: 3 }
      expected_sq = { file: 'd', rank: 2 }
      starts = [empty_sq, expected_sq]
      board = instance_double(Board)

      allow(board).to receive(:at).with(starts[0]).and_return nil
      allow(board).to receive(:at).with(starts[1]).and_return white_knight

      result = computer.find_knight(white_knight, board, starts)
      expect(result).to eq(expected_sq)
    end
  end # describe '#find_knight'
end
