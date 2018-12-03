defmodule TextClient.Player do

  alias TextClient.{Display, Mover, Prompter, State}
  
  # won, lost, good guess, bad guess, initializing, 
  def play(%State{tally: %{ game_state: :won }}) do
    msg_and_exit("You won the game!")
  end

  def play(%State{tally: %{ game_state: :lost }}) do
    msg_and_exit("You lost!  You are a big loser!")
  end

  def play(game = %State{tally: %{ game_state: :good_guess }}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{ game_state: :bad_guess }}) do
    continue_with_message(game, "Ooh, bad guess!")
  end

  def play(game = %State{tally: %{ game_state: :already_used }}) do
    continue_with_message(game, "You have already used that letter.")
  end

  def play(game) do
    continue_game(game)
  end

  defp continue_with_message(game, message) do
    IO.puts(message)
    continue_game(game)
  end
  
  defp continue_game(game) do
    game
    |> Display.show_game()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp msg_and_exit(msg) do
    IO.puts msg
    exit(:normal)
  end
end
