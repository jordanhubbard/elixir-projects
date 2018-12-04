defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game_state(word) do
    %Hangman.Game{
      letters:
        word
        |> String.downcase()
        |> String.codepoints()
    }
  end

  # If no word supplied, pick a random word.
  def new_game_state() do
    Dictionary.random_word() |> new_game_state()
  end

  # If game is already won or lost, don't alter it, just return the existing game.
  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    { game, tally(game) }
  end

  def tally(game) do
    %{ game |
       game_state: game.game_state,
       turns_left: game.turns_left,
       used: game.used,
       letters: reveal_guessed(game.letters, game.used)
    }
  end

  ########################### Private functions from this point forward ################################
  
  # We have already guessed this letter.
  defp accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  # We have NOT already guessed this letter.
  defp accept_move(game, guess, _already_guessed) do
    score_guess(Map.put(game, :used, MapSet.put(game.used, guess)), Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won()
    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game = %{turns_left: 1}, _not_good_guess) do
    Map.put(game, :game_state, :lost)
  end

  defp score_guess(game = %{turns_left: turns_left}, _not_good_guess) do
    %{game | game_state: :bad_guess, turns_left: turns_left - 1}
  end

  defp maybe_won(true), do:	:won
  defp maybe_won(_), do:	:good_guess

  defp reveal_guessed(letters, used) do
    Enum.map(letters, fn(letter) -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true),	do: letter
  defp reveal_letter(_letter, _not_in_word),	do: "_"

end
