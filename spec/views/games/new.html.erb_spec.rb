require 'rails_helper'

RSpec.describe "games/new", type: :view do
  it "renders new game form" do
    render
    assert_select "form[method=?]", "post" do
      assert_select "input[type=?]", "file"
    end
  end
end
