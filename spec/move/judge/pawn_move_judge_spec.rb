require './lib/move/judge/pawn_move_judge'
require './lib/board/board'
require './lib/move/pawn_move'
require './lib/standard/chess_piece'


RSpec.describe PawnMoveJudge do
  describe '#judge' do
    context "when the move is not a capture" do
      context "when there is one start square" do
        context "when the right pieces are in place" do
          subject(:judge) { described_class.new }

          it "returns true" do
            move = PawnMove.new
            move.target = { file: 'a', rank: 3 }
            move.starts = [{ file: 'a', rank: 2 }]
            move.capture = false
            move.moving_piece = { type: ChessPiece::PA, color: ChessPiece::WH }
            board = instance_double(Board)

            allow(judge).to receive(:check_target).with(move.target, board).and_return(true)
            allow(judge).to receive(:check_target).with(move.starts[0], board, move.moving_piece).and_return(true)
            expect(judge.judge_move(move, board)).to eq(true)
          end
        end
      end # context "when there is one start square"

      context "when there are two start squares" do
        context "when the start closer to target has the moving pawn" do
          subject(:judge) { described_class.new }
          
          it "returns true" do
            move = PawnMove.new
            move.target = { file: 'a', rank: 4 }
            move.starts = [{ file: 'a', rank: 3 }, { file: 'a', rank: 2 }]
            move.capture = false
            move.moving_piece = { type: ChessPiece::PA, color: ChessPiece::WH }
            board = instance_double(Board)

            allow(judge).to receive(:check_target).with(move.target, board).and_return(true)
            allow(judge).to receive(:check_target).with(move.starts[0], board, move.moving_piece).and_return(true)
            expect(judge.judge_move(move, board)).to eq(true)
          end
        end

        context "when the start further away from the target has the moving pawn" do
          subject(:judge) { described_class.new }
          
          it "returns true" do
            move = PawnMove.new
            move.target = { file: 'a', rank: 4 }
            move.starts = [{ file: 'a', rank: 3 }, { file: 'a', rank: 2 }]
            move.capture = false
            move.moving_piece = { type: ChessPiece::PA, color: ChessPiece::WH }
            board = instance_double(Board)

            allow(judge).to receive(:check_target).with(move.target, board).and_return(true)
            allow(judge).to receive(:check_target).with(move.starts[0], board, move.moving_piece).and_return(false)
            allow(judge).to receive(:check_target).with(move.starts[1], board, move.moving_piece).and_return(true)
            allow(judge).to receive(:check_target).with(move.starts[0], board).and_return(true)
            expect(judge.judge_move(move, board)).to eq(true)
          end
        end
      end # context "when there are two start squares"
    end # context "when the move is not a capture"

    context "when the move is a capture" do
    end # context "when the move is a capture"
  end
end
