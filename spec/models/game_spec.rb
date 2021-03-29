require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:players) }
    it { is_expected.to have_many(:rounds) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '.import' do
    subject { described_class }

    context "sucessful import" do
      let(:game) { build :game }

      before :each do
        allow_any_instance_of(GameService).to receive(:import_game).and_return(game)
      end

      it 'sucseeds' do
        expect(subject.import(Tempfile.new('filename', '/tmp'))).to eq game
      end
    end

    context 'import failure' do
      before :each do
        allow_any_instance_of(GameService).to receive(:import_game).and_raise("error")
      end

      it 'fails' do
        expect(subject.import(Tempfile.new('filename', '/tmp'))).to eq nil
      end
    end
  end
end
