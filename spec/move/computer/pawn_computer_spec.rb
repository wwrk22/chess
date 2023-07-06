require './lib/move/computer/pawn_computer'


RSpec.describe PawnComputer do

  describe '#compute_non_capture' do

    context "when the move is for a white pawn" do
      context "when the move is not a pawn's first move in a game" do
        subject(:computer) { described_class.new }

        it "computes the one starting square for the pawn" do
          target = { file: 'a', rank: 3 }
          player_color = ChessPiece::WH

          exp_output = [{ file: 'a', rank: 2 }]
          expect(computer.compute_non_capture(target, player_color)).to eq(exp_output)
        end
      end

      context "when the move is a pawn's first move in a game" do
        subject(:computer) { described_class.new }

        it "computes the two possible starting squares for the pawn" do
          target = { file: 'a', rank: 4 }
          player_color = ChessPiece::WH

          exp_output = [{ file: 'a', rank: 3 }, { file: 'a', rank: 2 }]
          expect(computer.compute_non_capture(target, player_color)).to eq(exp_output)
        end
      end
    end # context "when the move is for a white pawn"


    context "when the move is for a black pawn" do
      context "when the move is not a pawn's first move in a game" do
        subject(:computer) { described_class.new }

        it "computes the one starting square for the pawn" do
          target = { file: 'a', rank: 6 }
          player_color = ChessPiece::BL

          exp_output = [{ file: 'a', rank: 7 }]
          expect(computer.compute_non_capture(target, player_color)).to eq(exp_output)
        end
      end

      context "when the move is a pawn's first move in a game" do
        subject(:computer) { described_class.new }

        it "computes the two possible starting squares for the pawn" do
          target = { file: 'a', rank: 5 }
          player_color = ChessPiece::BL

          exp_output = [{ file: 'a', rank: 6 }, { file: 'a', rank: 7 }]
          expect(computer.compute_non_capture(target, player_color)).to eq(exp_output)
        end
      end
    end # context "when the move is for a black pawn"

  end
end
