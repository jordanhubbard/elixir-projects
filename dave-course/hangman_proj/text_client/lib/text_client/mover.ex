defmodule TextClient.Mover do
  alias TextClient.State
  
  def make_move(game) do
    %State{ game | tally: Hangman.make_move(game.game_service, game.guess) }
  end
end
