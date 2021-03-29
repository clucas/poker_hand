require 'rails_helper'

RSpec.describe Win, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:hand) }
    it { is_expected.to belong_to(:round) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:round) }
    it { is_expected.to validate_presence_of(:hand) }
  end
end
