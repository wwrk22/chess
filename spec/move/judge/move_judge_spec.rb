require './lib/move/judge/move_judge'
require './lib/move/pawn_move'
require './lib/board/board'
require './lib/standard/chess_piece'
require './lib/move/move'


RSpec.describe MoveJudge do
  describe '#judge_move' do
    subject(:judge) { described_class.new }
    let!(:board) { instance_double(Board) }
    let!(:m) do
      m = Move.new
      m.start = { file: 'a', rank: 1 }
      m.target = { file: 'a', rank: 2 }
      m.piece = { type: ChessPiece::RO, color: ChessPiece::WH }
      m.clear_path_required = true
      m
    end

    context "when the target square is not empty" do
      it "returns false" do
        allow(board).to receive(:at).with(m.target[:file], m.target[:rank]).and_return('a chess piece')

        expect(judge.judge_move(m, board)).to be_falsey
      end
    end

    context "when the target square is empty" do
      before :example do
        allow(board).to receive(:at).with(m.target[:file], m.target[:rank]).and_return(nil)
      end

      context "when the starting square does not have the moving piece" do
        it "returns false" do
          allow(board).to receive(:at).with(m.start[:file], m.start[:rank]).and_return(nil)

          expect(judge.judge_move(m, board)).to be_falsey
        end
      end

      context "when the starting square has the moving piece" do
        it "returns true/false for a clear/non-clear path respectively" do
          allow(board).to receive(:at).with(m.start[:file], m.start[:rank]).and_return(m.piece)
          direction = { file: 0, rank: 1 }
          allow(judge).to receive(:clear_path?).with(m.start, m.target, board, direction).and_return(true)

          expect(judge.judge_move(m, board)).to be_truthy
        end
      end
    end # context "when the target square is empty"
  end # describe '#judge_move'


  describe '#clear_path?' do
    subject(:judge) { described_class.new }

    context "when the direction does not lead to square b" do
      it "returns false" do
        a = { file: 'a', rank: 1 }
        b = { file: 'h', rank: 1 }
        direction = { file: 6, rank: 0 }
        board = instance_double(Board)

        result = judge.clear_path?(a, b, board, direction)
        expect(result).to be_falsey
      end
    end

    context "when the direction leads to square b" do
      context "when there are two squares on the path" do
        context "when the path is clear" do
          it "returns true" do
            a = { file: 'a', rank: 1 }
            b = { file: 'd', rank: 1 }
            direction = { file: 3, rank: 0 }
            board = instance_double(Board)
            allow(board).to receive(:at).with('c', 1).and_return(nil)
            allow(board).to receive(:at).with('b', 1).and_return(nil)

            result = judge.clear_path?(a, b, board, direction)
            expect(result).to be_truthy
          end
        end

        context "when the path is not clear" do
          it "returns false" do
            a = { file: 'a', rank: 1 }
            b = { file: 'd', rank: 1 }
            direction = { file: 3, rank: 0 }
            board = instance_double(Board)
            allow(board).to receive(:at).with('c', 1).and_return('a chess piece')

            result = judge.clear_path?(a, b, board, direction)
            expect(result).to be_falsey
          end
        end
      end # context "when there are two squares on the path"

      context "when there is one square on the path" do
        context "when the path is clear" do
          it "returns true" do
            a = { file: 'a', rank: 1 }
            b = { file: 'a', rank: 3 }
            direction = { file: 0, rank: 2 }
            board = instance_double(Board)
            allow(board).to receive(:at).with('a', 2).and_return(nil)

            result = judge.clear_path?(a, b, board, direction)
            expect(result).to be_truthy
          end
        end

        context "when the path is not clear" do
          it "returns false" do
            a = { file: 'a', rank: 1 }
            b = { file: 'a', rank: 3 }
            direction = { file: 0, rank: 2 }
            board = instance_double(Board)
            allow(board).to receive(:at).with('a', 2).and_return('a chess piece')

            result = judge.clear_path?(a, b, board, direction)
            expect(result).to be_falsey
          end
        end
      end # context "when there is one square on the path"

      context "when there are no squares on the path" do
        it "returns true" do
          a = { file: 'a', rank: 1 }
          b = { file: 'b', rank: 2 }
          direction = { file: 1, rank: 1 }
          board = instance_double(Board)

          result = judge.clear_path?(a, b, board, direction)
          expect(result).to be_truthy
        end
      end
    end # context "when the direction leads to square b"
  end # describe '#clear_path?'
end
