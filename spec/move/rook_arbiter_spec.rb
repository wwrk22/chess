require './lib/move/rook_arbiter'
require './lib/board/board'
require './lib/standards/piece'

RSpec.describe RookArbiter do
  subject(:arbiter) { described_class.new }

  describe '#judge' do
    context "when move is not a capture" do
      context "when the target square is not empty" do
        let!(:board) { instance_double(Board) }

        before do
          allow(board).to receive(:at).with('d', 4).and_return('some chess piece')
        end

        it "returns nil" do
          data = { capture: false, target: { f: 'd', r: 4 } }
          expect(arbiter.judge(board, data)).to be_nil
        end
      end

      context "when the target square is empty" do

        context "when there is only one possible starting square" do

          context "when there is a rook of the player color on the square" do
            let!(:board) { instance_double(Board) }

            before do
              allow(board).to receive(:at).with('d', 4).and_return(nil)
              allow(board).to receive(:at).with('a', 4).and_return({ type: Piece::RO, color: Piece::WH })
            end

            it "returns the one possible starting square" do
              data = {
                capture: false,
                target: { f: 'd', r: 4 },
                starts: [{ f: 'a', r: 4 }],
                color: Piece::WH
              }

              expected = { f: 'a', r: 4 }
              expect(arbiter.judge(board, data)).to eq(expected)
            end
          end

          context "when there is not a rook of the player color on the square" do

            context "when the square is empty" do

            end

            context "when the square is not empty" do

            end

          end # context "when there is not a rook of the player color on the square"

        end # context "when there is only one possible starting square"

        context "when there is more than one possible starting square" do

          context "when the starting squares are specified by a file" do

          end

          context "when the starting squares are specified by a rank" do

          end

          context "when there is no file or rank specified" do

          end

        end # context "when there are more than one possible starting square"

      end # context "when the target square is empty"

    end # context "when move is not a capture"

    context "when move is a capture" do

      context "when the target square is empty" do

      end

      context "when the target square is not empty" do
        
        context "when the target square holds an opponent's chess piece" do

        end

        context "when the target square does not hold an opponent's chess piece" do

        end

      end # context "when the target square is not empty"

    end # context "when move is a capture"

  end # describe '#judge'
end
