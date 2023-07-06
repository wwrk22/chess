require './lib/move/computer/pawn_computer'


RSpec.describe PawnComputer do

  describe '#compute_non_capture' do

    context "when the move is not a pawn's first move in a game" do
      
      subject(:computer) { described_class.new }

      it "computes the one starting square for the pawn" do

        exp_output = [{ file: 'a', rank: 2 }]

        target = { file: 'a', rank: 3 }

        player_color = ChessPiece::WH

        expect(computer.compute_non_capture(target, player_color)).to eq(exp_output)

      end

    end

    context "when the move is a pawn's first move in a game" do

      xit "computes the two possible starting squares for the pawn" do
      end

    end

  end
end
