require 'rails_helper'

RSpec.describe GamesHelper, type: :helper do
  describe "#card_cell" do
    context 'positive' do
      it 'renders the background color' do
         expect(helper.card_cell(true, 'content')).to eq "<td bgcolor=\"green\">content</td>"
      end
    end

    context 'negative' do
      it 'does not render the background color' do
        expect(helper.card_cell(false, 'content')).to eq "<td>content</td>"
      end
    end
  end
end
