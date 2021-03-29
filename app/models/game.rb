class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :rounds, dependent: :delete_all

  validates :name, presence: true

  def self.import(file)
    begin
      GameService.instance.import_game(file.path)
    rescue StandardError => e
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join('\n')
      nil
    end
  end
end
