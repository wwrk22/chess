require './lib/move/computer/pawn_computer'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe PawnComputer do
  describe '#compute_non_capture' do
    context "when the move is for a white pawn" do
      context "when the move is not a pawn's first move in a game" do
        subject(:computer) { described_class.new }

        it "computes the one starting square for the pawn" do
          target = { file: 'a', rank: 5 }
          player_color = white

          exp_output = [{ file: 'a', rank: 4 }]
          expect(computer.compute_non_capture(target, player_color)).to eq(exp_output)
        end
      end

      context "when the move is a pawn's first move in a game" do
        subject(:computer) { described_class.new }

        it "computes the two possible starting squares for the pawn" do
          target = { file: 'a', rank: 4 }
          player_color = white

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
          player_color = black

          exp_output = [{ file: 'a', rank: 7 }]
          expect(computer.compute_non_capture(target, player_color)).to eq(exp_output)
        end
      end

      context "when the move is a pawn's first move in a game" do
        subject(:computer) { described_class.new }

        it "computes the two possible starting squares for the pawn" do
          target = { file: 'a', rank: 5 }
          player_color = black

          exp_output = [{ file: 'a', rank: 6 }, { file: 'a', rank: 7 }]
          expect(computer.compute_non_capture(target, player_color)).to eq(exp_output)
        end
      end
    end # context "when the move is for a black pawn"
  end # describe '#compute_non_capture'


  describe '#compute_capture' do
    context "when the capture is for a white pawn" do
      context "when the capture is not an en-passant" do
        subject(:computer) { described_class.new }

        it "computes the one starting square" do
          target = { file: 'a', rank: 3 }
          player_color = white

          start_file = 'b'
          exp_output = [{ file: start_file, rank: 2 }]
          expect(computer.compute_capture(target, start_file, player_color)).to eq(exp_output)
        end
      end # context "when the capture is not an en passant"
    end # context "when the capture is for a white pawn"

    context "when the capture is for a black pawn" do
      context "when the capture is not an en-passant" do
        subject(:computer) { described_class.new }

        it "computes the one starting square" do
          target = { file: 'a', rank: 6 }
          player_color = black

          start_file = 'b'
          exp_output = [{ file: start_file, rank: 7 }]
          expect(computer.compute_capture(target, start_file, player_color)).to eq(exp_output)
        end
      end # context "when the capture is not an en-passant"
    end # context "when the capture is for a black pawn"
  end
end
