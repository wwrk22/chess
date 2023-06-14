require './lib/player'

RSpec.describe Player do
  describe '#prompt_move' do
    context "when player color is white" do
      context "when move syntax is valid" do
        subject(:white_valid) { described_class.new('Foo', Pieces::WH) }
        let(:valid_move) { 'a3' }
        let(:syn_vtor) { instance_double(SyntaxValidator) }

        it "returns a hash of the move and the player's color" do
          allow(white_valid).to receive(:gets).and_return(valid_move)
          allow(syn_vtor).to receive(:validate).and_return(true)
          white_valid.instance_variable_set(:@syn_vtor, syn_vtor)

          exp_out = { move: valid_move, color: Pieces::WH }
          expect(white_valid.prompt_move).to eq(exp_out)
        end
      end

      context "when move syntax is invalid" do
      end
    end

    context "when player color is black" do
      context "when move syntax is valid" do
      end

      context "when move syntax is invalid" do
      end
    end
  end
end
