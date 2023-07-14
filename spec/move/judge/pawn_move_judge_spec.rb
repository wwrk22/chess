require './lib/move/judge/pawn_move_judge'
require './lib/move/pawn_move'
require './lib/board/board'
require './lib/standard/chess_piece'


RSpec.describe PawnMoveJudge do
  describe '#check_target' do
    context "when the target square is to be empty" do
      context "when the target square is empty" do
        subject(:judge) { described_class.new }

        it "returns true" do
          target_square = { file: 'a', rank: 1 }

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return(nil)

          result = judge.check_target(target_square, board)
          expect(result).to be_truthy
        end
      end

      context "when the target square is not empty" do
        subject(:judge) { described_class.new }

        it "returns false" do
          target_square = { file: 'a', rank: 1 }

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return('a chess piece')

          result = judge.check_target(target_square, board)
          expect(result).to be_falsey
        end
      end
    end # context "when the target square is to be empty"

    context "when the target square must have a chess piece of the specified color" do
      context "when the the target square is empty" do
        subject(:judge) { described_class.new }

        it "returns false" do
          target_square = { file: 'a', rank: 1 }
          target_color = ChessPiece::WH

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return(nil)

          result = judge.check_target(target_square, board, target_color)
          expect(result).to be_falsey
        end
      end

      context "when the target square has a chess piece of the specified color" do
        subject(:judge) { described_class.new }

        it "returns true" do
          target_square = { file: 'a', rank: 1 }
          target_color = ChessPiece::WH

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return({ type: ChessPiece::PA, color: ChessPiece::WH })

          result = judge.check_target(target_square, board, target_color)
          expect(result).to be_truthy
        end
      end

      context "when the target square has a chess piece of the player's own color" do
        subject(:judge) { described_class.new }

        it "returns false" do
          target_square = { file: 'a', rank: 1 }
          target_color = ChessPiece::BL

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return({ type: ChessPiece::PA, color: ChessPiece::WH })

          result = judge.check_target(target_square, board, target_color)
          expect(result).to be_falsey
        end
      end
    end # context "when the target square must have a chess piece of the specified color"
  end # describe '#check_target'
end
