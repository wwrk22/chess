require './lib/move/pawn_arbiter'
require './lib/board/board'
require './lib/standards/piece'

RSpec.describe PawnArbiter do
  subject(:arbiter) { described_class.new }

  describe '#judge' do
    context "when the move is not a capture" do
      context "when the target square is not empty" do
        let!(:board) { instance_double(Board) }

        before do
          allow(board).to receive(:at).with('a', 3).and_return("some chess piece")
        end

        it "returns nil" do
          data = { capture: false, target: { f: 'a', r: 3 } }
          expect(arbiter.judge(board, data)).to be_nil
        end
      end

      context "when the target square is empty" do
        context "when there is only one possible starting square" do
          context "when there is a pawn of the player's color on the square" do
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('a', 3).and_return(nil)
              allow(board).to receive(:at).with('a', 2).and_return({ piece: Piece::PA, color: Piece::WH })
            end

            it "returns the square" do
              data = { capture: false, target: { f: 'a', r: 3 }, starts: [{ f: 'a', r: 2 }], color: Piece::WH }
              exp_start_sq = { f: 'a', r: 2 }
              expect(arbiter.judge(board, data)).to eq(exp_start_sq)
            end
          end

          context "when the starting square is empty" do
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('a', 3).and_return(nil)
              allow(board).to receive(:at).with('a', 2).and_return(nil)
            end

            it "returns nil" do
              data = { capture: false, target: { f: 'a', r: 3 }, starts: [{ f: 'a', r: 2 }] }
              expect(arbiter.judge(board, data)).to be_nil
            end
          end # context "when the only starting square is empty"

          context "when the there is a non-pawn piece of the player's color on the square" do
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('a', 3).and_return(nil)
              allow(board).to receive(:at).with('a', 2).and_return({ piece: Piece::RO, color: Piece::WH })
            end

            it "returns nil" do
              data = {
                capture: false,
                target: { f: 'a', r: 3 },
                starts: [{ f: 'a', r: 2 }],
                color: Piece::WH
              }
              expect(arbiter.judge(board, data)).to be_nil
            end
          end # context "when the there is a non-pawn piece of the player's color on the square"

          context "when there is a piece of the opponent's color on the square" do
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('a', 3).and_return(nil)
              allow(board).to receive(:at).with('a', 2).and_return({ piece: Piece::PA, color: Piece::BL })
            end

            it "returns nil" do
              data = {
                capture: false,
                target: { f: 'a', r: 3 },
                starts: [{ f: 'a', r: 2 }],
                color: Piece::WH
              }
              expect(arbiter.judge(board, data)).to be_nil
            end
          end # context "when there is a piece of the opponent's color on the square"
        end # context "when there is only one possible starting square"

        context "when there are two possible starting squares" do
          context "when there is no pawn of the player's color on either square" do
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
              expect(arbiter.judge(board, data)).to be_nil
            end
          end

          context "when there is a pawn of the player's color on the square closer to the target" do
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
              expect(arbiter.judge(board, data)).to eq(data[:starts][0])
            end
          end

          context "when there is a pawn of the player's color on the square further from the target" do
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
              expect(arbiter.judge(board, data)).to eq(data[:starts][1])
            end
          end # context "when there is a pawn of the player's color on the square further from the target"
        end # context "when there are two possible starting squares"
      end # context "when the target square is empty"
    end # context "when the move is not a capture"

    context "when the move is a capture" do
      context "when target square has a piece of the opponent's color" do
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
          expect(arbiter.judge(board, data)).to eq(data[:starts][0])
        end
      end

      context "when target square does not have a piece of the opponent's color" do
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
          expect(arbiter.judge(board, data)).to be_nil
        end
      end # context "when target square does not have a piece of the opponent's color"

      context "when target square has a piece of the player's color" do
        let!(:board) { instance_double(Board) }

        before do
          allow(board).to receive(:at).with('a', 3).and_return({ piece: Piece::PA, color: Piece::WH })
        end
        
        it "returns nil" do
          data = {
            capture: true,
            target: { f: 'a', r: 3 },
            starts: [{ f: 'b', r: 2 }],
            color: Piece::WH
          }
          expect(arbiter.judge(board, data)).to be_nil
        end
      end # context "when target square has a piece of the player's color"
    end # context "when the move is a capture"
  end # describe '#judge'
end
