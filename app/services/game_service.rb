class GameService
  include Singleton

  # Create a game from an imported data file
  def import_game(file_path)
    ActiveRecord::Base.transaction do
      game = Game.create!(name: "Game #{Time.now.to_i}")
      game_data = parse_data(file_path)
      game_data.keys.each do |r|
        round = Round.create!(number: r, game: game)
        game_data[r].keys.each do |p|
          player = Player.find_or_create_by(name: "player #{p}", game: game)
          Hand.create!(number: round.number, card_list: game_data[r][p].join(' '), player: player, round: round)
        end
      end
      game.rounds.collect{ |r| r.find_winning_hand }
      game
    end
  end

  private

  def parse_data(file_path)
    game_data = {}
    round = 1
    File.foreach(file_path) do |line|
      user_index = 1
      line.split(' ').each_slice(Hand::NUMBER_OF_CARDS).to_a.each do |user|
        game_data[round] ||= {}
        game_data[round][user_index] = user
        user_index += 1
      end
      round += 1
    end
    game_data
  end
end