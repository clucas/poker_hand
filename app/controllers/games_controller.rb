class GamesController < ApplicationController
  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/1 or /games/1.json
  def show
    @game = Game.includes(:players, rounds: [:win, hands: [:win]]).find(params[:id])
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games or /games.json
  def create
    @game = Game.import game_params[:file]
    respond_to do |format|
      if @game
        format.html { redirect_to @game, notice: "Game was successfully imported." }
      else
        format.html { redirect_to games_path, notice: "Game failed to import." }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:file)
    end
end
