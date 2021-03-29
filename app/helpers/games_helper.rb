module GamesHelper
  def card_cell(positive, content)
    positive ? tag.td(content, { bgcolor: 'green'}) : tag.td(content)
  end
end
