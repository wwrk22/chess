require './lib/move/move_arbiter'
require './lib/board/board'
require './lib/standards/piece'

RSpec.describe MoveArbiter do

  describe '#judge_pawn_move' do
    context "when the move is not a capture" do
      context "when the target square is not empty" do
        subject(:arbiter) { described_class.new }
        let!(:board) { instance_double(Board) }

        before do
          allow(board).to receive(:at).with('a', 3).and_return("some chess piece")
        end

        it "returns nil" do
          data = { capture: false, target: { f: 'a', r: 3 } }
          start_sq = arbiter.judge_pawn_move(board, data)
          expect(start_sq).to be_nil
        end
      end

      context "when the target square is empty" do
        context "when there is only one possible starting square" do
          context "when there is a pawn of the player's color on the square" do
            subject(:arbiter) { described_class.new }
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('a', 3).and_return(nil)
              allow(board).to receive(:at).with('a', 2).and_return({ piece: Piece::PA, color: Piece::WH })
            end

            it "returns the square" do
              data = { capture: false, target: { f: 'a', r: 3 }, starts: [{ f: 'a', r: 2 }], color: Piece::WH }
              start_sq = arbiter.judge_pawn_move(board, data)
              exp_start_sq = { f: 'a', r: 2 }
              expect(start_sq).to eq(exp_start_sq)
            end
          end

          context "when there is not a pawn of the player's color on the square" do
            subject(:arbiter) { described_class.new }
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('a', 3).and_return(nil)
              allow(board).to receive(:at).with('a', 2).and_return(nil)
            end

            it "returns nil" do
              data = { capture: false, target: { f: 'a', r: 3 }, starts: [{ f: 'a', r: 2 }] }
              start_sq = arbiter.judge_pawn_move(board, data)
              expect(start_sq).to be_nil
            end
          end
        end # context "when there is only one possible starting square"

        context "when there are two possible starting squares" do
          context "when there is no pawn of the player's color on either square" do
            subject(:arbiter) { described_class.new }
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('a', 4).and_return(nil)
              allow(board).to receive(:at).with('a', 3).and_return(nil)
              allow(board).to receive(:at).with('a', 2).and_return(nil)
            end

            it "returns nil" do
              data = {
                capture: false,
                target: { f: 'a', r: 4 },
                starts: [{ f: 'a', r: 3 }, { f: 'a', r: 2 }],
                color: Piece::WH
              }
              start_sq = arbiter.judge_pawn_move(board, data)
              expect(start_sq).to be_nil
            end
          end

          context "when there is a pawn of the player's color on the square closer to the target" do
            subject(:arbiter) { described_class.new }
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('a', 4).and_return(nil)
              allow(board).to receive(:at).with('a', 3).and_return({ piece: Piece::PA, color: Piece::WH })
            end

            it "returns the square" do
              data = {
                capture: false,
                target: { f: 'a', r: 4 },
                starts: [{ f: 'a', r: 3 }, { f: 'a', r: 2 }],
                color: Piece::WH
              }
              start_sq = arbiter.judge_pawn_move(board, data)
              expect(start_sq).to eq(data[:starts][0])
            end
          end

          context "when there is a pawn of the player's color on the square further from the target" do
            subject(:arbiter) { described_class.new }
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('a', 4).and_return(nil)
              allow(board).to receive(:at).with('a', 3).and_return(nil)
              allow(board).to receive(:at).with('a', 2).and_return({ piece: Piece::PA, color: Piece::WH })
            end

            it "returns the square" do
              data = {
                capture: false,
                target: { f: 'a', r: 4 },
                starts: [{ f: 'a', r: 3 }, { f: 'a', r: 2 }],
                color: Piece::WH
              }
              start_sq = arbiter.judge_pawn_move(board, data)
              expect(start_sq).to eq(data[:starts][1])
            end
          end # context "when there is a pawn of the player's color on the square further from the target"
        end # context "when there are two possible starting squares"
      end # context "when the target square is empty"
    end # context "when the move is not a capture"

    context "when the move is a capture" do
      context "when target square has a piece of the opponent's color" do
        subject(:arbiter) { described_class.new }
        let!(:board) { instance_double(Board) }

        before do
          allow(board).to receive(:at).with('a', 3).and_return({ piece: Piece::PA, color: Piece::BL })
          allow(board).to receive(:at).with('b', 2).and_return({ piece: Piece::PA, color: Piece::WH })
        end

        it "returns the starting square of the capturing pawn" do
          data = {
            capture: true,
            target: { f: 'a', r: 3 },
            starts: [{ f: 'b', r: 2 }],
            color: Piece::WH
          }
          start_sq = arbiter.judge_pawn_move(board, data)
          expect(start_sq).to eq(data[:starts][0])
        end
      end

      context "when target square does not have a piece of the opponent's color" do
        subject(:arbiter) { described_class.new }
        let!(:board) { instance_double(Board) }

        before do
          allow(board).to receive(:at).with('a', 3).and_return(nil)
        end
        
        it "returns nil" do
          data = {
            capture: true,
            target: { f: 'a', r: 3 },
            starts: [{ f: 'b', r: 2 }],
            color: Piece::WH
          }
          start_sq = arbiter.judge_pawn_move(board, data)
          expect(start_sq).to be_nil
        end
      end # context "when target square does not have a piece of the opponent's color"
    end # context "when the move is a capture"
  end # describe '#judge_pawn_move'

end
