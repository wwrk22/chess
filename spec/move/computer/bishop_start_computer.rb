require './lib/move/computer/bishop_start_computer'
require './lib/move/move'
require './lib/board/board'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe BishopStartComputer do
  describe '#compute_move' do
    subject(:computer) { described_class.new }

    it "returns the starting square if it exists" do
      move = instance_double(Move)
      board = instance_double(Board)
      check_multiple_paths_args = [move, board, BishopSpecs::DIRECTIONS]

      expect(computer).to receive(:check_multiple_paths).with(*check_multiple_paths_args)
      computer.compute_move(move, board)
    end
  end # describe '#compute_move'

  
  describe '#compute_with_file' do
    subject(:computer) { described_class.new }

    context "when two starting squares are possible" do
      it "returns the two squares on the starting file that the bishop can move from" do
        target_square = { file: 'e', rank: 3 }
        start_file = 'c'
        expected = [{ file: start_file, rank: 1 }, { file: start_file, rank: 5 }]

        starting_squares = computer.compute_with_file(target_square, start_file)

        result = expected.difference(starting_squares).none? &&
                 starting_squares.difference(expected).none?
        expect(result).to be_truthy
      end
    end

    context "when only one starting square is possible" do
      it "returns the one square on the starting file that the bishop can move from" do
        target_square = { file: 'c', rank: 1 }
        start_file = 'b'
        expected = [{ file: start_file, rank: 2 }]

        starting_square = computer.compute_with_file(target_square, start_file)

        result = expected.difference(starting_square).none? &&
                 starting_square.difference(expected).none?
        expect(result).to be_truthy
      end
    end
  end # describe '#compute_with_file'
end
