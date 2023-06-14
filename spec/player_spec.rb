require './lib/player'

RSpec.describe Player do
  describe '#prompt_move' do
    let(:syn_vtor) { instance_double(SyntaxValidator) }

    context "when move syntax is valid" do
      subject(:player) { described_class.new('Foo', Pieces::WH) }
      let(:valid_move) { 'a3' }

      it "returns a hash of the move and the player's color" do
        allow(player).to receive(:gets).and_return(valid_move)
        allow(syn_vtor).to receive(:validate).and_return(true)
        player.instance_variable_set(:@syn_vtor, syn_vtor)

        exp_out = { move: valid_move, color: Pieces::WH }
        expect(player.prompt_move).to eq(exp_out)
      end
    end # context "when move syntax is valid"

    context "when move syntax is invalid" do
      subject(:player) { described_class.new('Foo', Pieces::BL) }
      let(:invalid_move) { 'a8' }

      it "returns nil" do
        allow(player).to receive(:gets).and_return(invalid_move)
        allow(syn_vtor).to receive(:validate).and_return(false)
        player.instance_variable_set(:@syn_vtor, syn_vtor)

        expect(player.prompt_move).to be_nil
      end
    end # context "when move syntax is invalid"

  end # #prompt_move
end
