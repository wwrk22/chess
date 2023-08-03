require './lib/move/computer/rook_start_computer'
require './lib/piece/chess_piece'
require './lib/piece/rook_specs'
require './lib/piece/piece_specs'
require './lib/move/move'
require './lib/board/board'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe RookStartComputer do

  describe '#compute_move' do
    subject(:computer) { described_class.new }

    it "returns the starting square if it exists" do
      move = instance_double(Move)
      board = instance_double(Board)
      check_multiple_paths_args = [move, board, RookSpecs::DIRECTIONS]

      expect(computer).to receive(:check_multiple_paths).with(*check_multiple_paths_args)
      computer.compute_move(move, board)
    end
  end # describe '#compute_move'


  describe '#compute_with_start_coordinate' do
    subject(:computer) { described_class.new }

    let!(:board) { instance_double(Board) }
    let!(:moving_rook) { ChessPiece.new(rook, white) }
    let!(:target_square) { { file: 'd', rank: 4 } }

    context "when the starting coordinate is a file" do
      let!(:start_coordinate) { 'a' }
      let!(:expected) { { file: 'a', rank: 4 } }

      context "when the starting square has the moving rook" do
        it "returns a square with that file and the same rank as the target square" do 
          allow(board).to receive(:at).with(expected[:file], expected[:rank]).and_return moving_rook

          result = computer.compute_with_start_coordinate(target_square, start_coordinate, board, moving_rook)
          expect(result).to eq(expected)
        end
      end

      context "when the starting square does not have the moving rook" do
        it "returns nil" do
          allow(board).to receive(:at).with(expected[:file], expected[:rank]).and_return nil

          result = computer.compute_with_start_coordinate(target_square, start_coordinate, board, moving_rook)
          expect(result).to be_nil
        end
      end
    end # context "when the starting coordinate is a file"

    context "when the starting coordinate is a rank" do
      let!(:start_coordinate) { 2 }
      let!(:expected) { { file: 'd', rank: 2 } }

      context "when the starting square has the moving rook" do
        it "returns a square with that rank and the same file as the target square" do
          allow(board).to receive(:at).with(expected[:file], expected[:rank]).and_return moving_rook

          result = computer.compute_with_start_coordinate(target_square, start_coordinate, board, moving_rook)
          expect(result).to eq(expected)
        end
      end

      context "when the starting square does not have the moving rook" do
        it "returns nil" do
          allow(board).to receive(:at).with(expected[:file], expected[:rank]).and_return nil

          result = computer.compute_with_start_coordinate(target_square, start_coordinate, board, moving_rook)
          expect(result).to be_nil
        end
      end
    end # context "when the starting coordinate is a rank"
  end # describe '#compute_with_start_coordinate'
end
