defmodule TextClient.Display do
  def show_game(game = %{ tally: tally }) do
    IO.puts [
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Letters used: #{MapSet.to_list(tally.used)}\n",
      "Guesses left: #{tally.turns_left}\n"
    ]
    game
  end
end

