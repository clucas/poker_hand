module GamesHelper
  def card_cell(positive, content)
    positive ? tag.td(content, { bgcolor: 'green', style: 'color:white' }) : tag.td(content)
  end
end
