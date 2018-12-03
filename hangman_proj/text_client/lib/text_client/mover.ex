defmodule TextClient.Mover do
  alias TextClient.State
  
  def make_move(game) do
    {g, t} = Hangman.make_move(game.game_service, game.guess)
    %State{ game | game_service: g, tally: t}
  end
end
