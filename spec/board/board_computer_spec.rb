require './lib/board/board_computer'


RSpec.describe BoardComputer do
  let(:computer) { Class.new { extend BoardComputer } }

  describe '#compute_direction' do
    context "when the path is horizontal" do
      context "when going from left to right" do
        context "when the ending square is on the path" do
          it "returns the directions" do
            a = { file: 'a', rank: 1 }
            b = { file: 'h', rank: 1 }

            computed_direction = computer.compute_direction(a, b)
            correct_direction = { file: 7, rank: 0 }

            expect(computed_direction).to eq(correct_direction)
          end
        end

        context "when the ending square is not on the path" do
        end
      end

      context "when going from right to left" do
      end
    end

    context "when the path is vertical" do
      context "when going from top to bottom" do
      end

      context "when going from bottom to top" do
      end
    end

    context "when the path is diagonal" do
    end
  end
end
