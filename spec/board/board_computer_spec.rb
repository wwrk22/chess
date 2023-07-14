require './lib/board/board_computer'


RSpec.describe BoardComputer do
  let(:computer) { Class.new { extend BoardComputer } }

  describe '#compute_direction' do
    context "when the path is horizontal" do
      context "when going from left to right" do
        context "when the squares are on a straight path" do
          it "returns the direction" do
            a = { file: 'a', rank: 1 }
            b = { file: 'h', rank: 1 }
            computed_direction = computer.compute_direction(a, b)
            correct_direction = { file: 7, rank: 0 }

            expect(computed_direction).to eq(correct_direction)
          end
        end

        context "when the squares are not on a straight path" do
          it "returns nil" do
            a = { file: 'a', rank: 1 }
            b = { file: 'h', rank: 2 }
            computed_direction = computer.compute_direction(a, b)
            
            expect(computed_direction).to be_nil
          end
        end
      end # context "when going from left to right"

      context "when going from right to left" do
        context "when the squares are on a straight path" do
          it "returns the direction" do
            a = { file: 'h', rank: 1 }
            b = { file: 'a', rank: 1 }
            computed_direction = computer.compute_direction(a, b)
            correct_direction = { file: -7, rank: 0 }

            expect(computed_direction).to eq(correct_direction)
          end
        end

        context "when the squares are not on a straight path" do
          it "returns nil" do
            a = { file: 'h', rank: 1 }
            b = { file: 'a', rank: 2 }

            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to be_nil
          end
        end
      end # context "when going from right to left"
    end # context "when the path is horizontal"

    context "when the path is vertical" do
      context "when going from top to bottom" do
        context "when the squares are on a straight path" do
          it "returns the direction" do
            a = { file: 'a', rank: 8 }
            b = { file: 'a', rank: 1 }
            correct_direction = { file: 0, rank: -7 }

            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to eq(correct_direction)
          end
        end

        context "when the squares are not on a straight path" do
          it "returns nil" do
            a = { file: 'a', rank: 8 }
            b = { file: 'b', rank: 1 }
            
            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to be_nil
          end
        end
      end # context "when going from top to bottom"

      context "when going from bottom to top" do
        context "when the squares are on a straight path" do
          it "returns the direction" do
            a = { file: 'a', rank: 1 }
            b = { file: 'a', rank: 8 }
            correct_direction = { file: 0, rank: 7 }

            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to eq(correct_direction)
          end
        end

        context "when the squares are not on a straight path" do
          it "returns nil" do
            a = { file: 'a', rank: 1 }
            b = { file: 'b', rank: 8 }
            
            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to be_nil
          end
        end
      end # context "when going from bottom to top"
    end # context "when the path is vertical"

    context "when the path is diagonal" do
      context "when going from top-left to bottom-right" do
        context "when the squares are on a straight path" do
          it "returns the direction" do
            a = { file: 'a', rank: 8 }
            b = { file: 'd', rank: 5 }
            correct_direction = { file: 3, rank: -3 }

            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to eq(correct_direction)
          end
        end

        context "when the squares are not on a straight path" do
          it "returns nil" do
            a = { file: 'a', rank: 8 }
            b = { file: 'd', rank: 6 }
            
            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to be_nil
          end
        end
      end # context "when going from top-left to bottom-right"
      
      context "when going from bottom-right to top-left" do
        context "when the squares are on a straight path" do
          it "returns the direction" do
            a = { file: 'd', rank: 5 }
            b = { file: 'a', rank: 8 }
            correct_direction = { file: -3, rank: 3 }

            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to eq(correct_direction)
          end
        end

        context "when the squares are not on a straight path" do
          it "returns nil" do
            a = { file: 'd', rank: 5 }
            b = { file: 'a', rank: 7 }

            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to be_nil
          end
        end
      end # context "when going from bottom-right to top-left"

      context "when going from bottom-left to top-right" do
        context "when the squares are on a straight path" do
          it "returns the direction" do
            a = { file: 'a', rank: 1 }
            b = { file: 'h', rank: 8 }
            correct_direction = { file: 7, rank: 7 }

            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to eq(correct_direction)
          end
        end

        context "when the squares are not on a straight path" do
          it "returns nil" do
            a = { file: 'a', rank: 1 }
            b = { file: 'h', rank: 7 }
            
            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to be_nil
          end
        end
      end # context "when going from bottom-left to top-right"

      context "when going from top-right to bottom-left" do
        context "when the squares are on a straight path" do
          it "returns the direction" do
            a = { file: 'h', rank: 8 }
            b = { file: 'a', rank: 1 }
            correct_direction = { file: -7, rank: -7 }

            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to eq(correct_direction)
          end
        end

        context "when the squares are not on a straight path" do
          it "returns nil" do
            a = { file: 'h', rank: 8 }
            b = { file: 'a', rank: 2 }

            computed_direction = computer.compute_direction(a, b)
            expect(computed_direction).to be_nil
          end
        end
      end # context "when going from top-right to bottom-left"
    end # context "when the path is diagonal"
  end # describe '#compute_direction'
end
