require 'support/matchers/chess_piece'
require 'support/board/board_setter'
require './lib/board/board'
require './lib/move/computer/pawn_start_computer'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'
require './lib/move/move'
require_relative './test_moves/pawn'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
  cfg.include TestMoves::Pawn
  cfg.include BoardSetter
end

RSpec.describe PawnStartComputer do
  subject(:computer) { described_class.new }

  describe '#compute_capture_start' do
    context "when pawn is white" do
      it "returns a square whose rank is one less than the target" do
        target_square = { file: 'a', rank: 3 }
        expected_start = { file: 'b', rank: 2 }
        move = instance_double(Move)
        allow(move).to receive(:target).and_return(target_square)

        computed_start = computer.compute_capture_start(white, expected_start[:file], target_square)
        expect(computed_start).to eq(expected_start)
      end
    end

    context "when pawn is black" do
      it "returns a square whose rank is one more than the target" do
        target_square = { file: 'a', rank: 6 }
        expected_start = { file: 'b', rank: 7 }
        move = instance_double(Move)
        allow(move).to receive(:target).and_return(target_square)

        computed_start = computer.compute_capture_start(black, expected_start[:file], target_square)
        expect(computed_start).to eq(expected_start)
      end
    end # context "when pawn is black"
  end # describe '#compute_capture'


  describe '#compute_capture' do
    it "returns a boolean to indicate whether the starting square could be determined" do
      move = instance_double(Move)
      board = instance_double(Board)
      white_pawn = instance_double(ChessPiece)
      expected_start = { file: 'b', rank: 2 }

      allow(white_pawn).to receive(:type).and_return(pawn)
      allow(white_pawn).to receive(:color).and_return(white)

      allow(move).to receive(:piece).and_return(white_pawn)
      allow(move).to receive(:start_coordinate).and_return('b')
      allow(move).to receive(:target).and_return({ file: 'a', rank: 3 })

      allow(board).to receive(:at).with(expected_start).and_return(white_pawn)

      result = computer.compute_capture(move, board)
      expect(result).to eq(expected_start)
    end
  end # describe '#compute_capture'


  describe '#calculate_limit' do
    context "when the target square rank is four and the pawn is white" do
      it "returns two" do
        result = computer.calculate_limit(white, 4)
        expect(result).to eq(2)
      end
    end

    context "when the target square rank is five and the pawn is black" do
      it "returns two" do
        result = computer.calculate_limit(black, 5)
        expect(result).to eq(2)
      end
    end

    context "when the target square rank cannot be a double move" do
      it "returns one" do
        result = computer.calculate_limit(white, 3)
        expect(result).to eq(1)
      end
    end
  end # describe '#calculate_limit'


  describe '#compute_start' do
    let!(:board) { Board.new }

    context "when the move is a legal single" do
      context "when pawn is white" do
        it "returns the square one below the target square" do
          set_ranks(board, (2..7).to_a, pawn, white) 

          result = white_singles.all? do |move|
            computer.compute_start(move[:move], board) == move[:exp_start]
          end

          expect(result).to eq(true)
        end
      end # context "when pawn is white"

      context "when pawn is black" do
        it "returns the square one above the target square" do
          set_ranks(board, (2..7).to_a, pawn, black)

          result = black_singles.all? do |move|
            computer.compute_start(move[:move], board) == move[:exp_start]
          end

          expect(result).to eq(true)
        end
      end
    end # context "when the move is a legal single"

    context "when the move is a legal double" do
      context "when the pawn is white" do
        it "returns the square two below the target square" do
          set_ranks(board, [2], pawn, white)
          
          result = white_doubles.all? do |move|
            computer.compute_start(move[:move], board) == move[:exp_start]
          end

          expect(result).to eq(true)
        end
      end
      
      context "when the pawn is black" do
        it "returns the square two above the target square" do
          set_ranks(board, [7], pawn, black)
          
          result = black_doubles.all? do |move|
            computer.compute_start(move[:move], board) == move[:exp_start]
          end
          
          expect(result).to eq(true)
        end
      end
    end # context "when the move is a legal double"

    context "when the move is a capture" do
      context "when the pawn is white" do
        context "when the move is not en passant" do
          it "computes the correct start" do
            set_ranks(board, [6], pawn, black)
            set_ranks(board, [5], pawn, white)

            result = captures(6, white, -1).all? do |move|
              computer.compute_start(move[:move], board) == move[:exp_start]
            end

            expect(result).to eq(true)
          end
        end

        context "when the move is en passant" do
          it "computes the correct start" do
            target_files = ['a', 'c', 'e', 'g']

            target_files.each do |file|
              board.set({ file: file, rank: 5 }, ChessPiece.new(pawn, black))
            end

            ['b', 'd', 'f', 'h'].each do |file|
              board.set({ file: file, rank: 5 }, ChessPiece.new(pawn, white))
            end

            result = en_passants(target_files, white).all? do |move|
              computer.compute_start(move[:move], board) == move[:exp_start]
            end

            expect(result).to eq(true)
          end
        end
      end # context "when the pawn is white"

      context "when the pawn is black" do
        context "when the move is not en passant" do
          it "computes the correct start" do
            set_ranks(board, [3], pawn, white)
            set_ranks(board, [4], pawn, black)

            result = captures(3, black, 1).all? do |move|
              computer.compute_start(move[:move], board) == move[:exp_start]
            end

            expect(result).to eq(true)
          end
        end

        context "when the move is en passant" do
        end
      end # context "when the pawn is black"
    end # context "when the move is a capture"
  end # describe '#compute_start'
end
