require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, FactoryBot.create_list(:game, 2))
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", text: Game.last(2).first.name, count: 1
    assert_select "tr>td", text: Game.last.name, count: 1
  end
end
