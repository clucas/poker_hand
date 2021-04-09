require 'rails_helper'

RSpec.describe Round, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to have_many(:hands) }
    it { is_expected.to have_many(:players) }
    it { is_expected.to have_one(:win) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:game) }
  end

  describe '#find_winning_hand' do
    let(:game) { create :game, name: 'new_game'}
    let(:player1) { create :player, game: game }
    let(:player2) { create :player, game: game }
    let(:round) { create :round, game: game }
    let!(:hand1) { create :hand, card_list: 'TS 9H AH AD 8S', round: round, player: player1 }
    let!(:hand2) { create :hand, card_list: '9S 3H 9D JD 5C', round: round, player: player2 }

    it 'finds the wimnning hand' do
      win = round.find_winning_hand
      expect(win.status).to be_truthy
      expect(win.hand).to eq hand1
      expect(win.rank).to eq 'one_pair'
    end
  end

  describe '#find winning pair hand' do
    let(:game) { create :game, name: 'new_game'}
    let(:player1) { create :player, game: game }
    let(:player2) { create :player, game: game }
    let(:round) { create :round, game: game }
    let!(:hand1) { create :hand, card_list: '5H KS 9C 7D 9H', round: round, player: player1 }
    let!(:hand2) { create :hand, card_list: '8D 3S 5D 5C AH', round: round, player: player2 }

    it 'finds the wimnning hand' do
      win = round.find_winning_hand
      expect(win.status).to be_truthy
      expect(win.hand).to eq hand1
      expect(win.rank).to eq 'one_pair'
    end
  end

  describe '#find winning three of a kind hand' do
    let(:game) { create :game, name: 'new_game'}
    let(:player1) { create :player, game: game }
    let(:player2) { create :player, game: game }
    let(:round) { create :round, game: game }
    let!(:hand1) { create :hand, card_list: '9H KS 9C 7D 9H', round: round, player: player1 }
    let!(:hand2) { create :hand, card_list: '8D 8S 8D 5C AH', round: round, player: player2 }

    it 'finds the wimnning hand' do
      win = round.find_winning_hand
      expect(win.status).to be_truthy
      expect(win.hand).to eq hand1
      expect(win.rank).to eq 'three_of_a_kind'
    end
  end
end
