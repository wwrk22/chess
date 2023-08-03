require './lib/move/computer/queen_start_computer'
require './lib/piece/queen_specs'
require './lib/move/move'
require './lib/board/board'


RSpec.describe QueenStartComputer do
  describe '#compute_move' do
    subject(:computer) { described_class.new }

    it "returns the starting square if it exists" do
      move = instance_double(Move)
      board = instance_double(Board)
      check_multiple_paths_args = [move, board, QueenSpecs::DIRECTIONS]

      expect(computer).to receive(:check_multiple_paths).with(*check_multiple_paths_args)
      computer.compute_move(move, board)
    end
  end # describe '#compute_move'
end
