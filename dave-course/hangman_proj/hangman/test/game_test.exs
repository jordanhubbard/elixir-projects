defmodule GameTest do
  use ExUnit.Case
  doctest Hangman.Game

  alias Hangman.Game

  test "new game returns good structure" do
    game = Game.new_game_state()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "new game for known word looks correct" do
    game = Game.new_game_state("Bollocks")	# Also test that downcase is working
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ["b", "o", "l", "l", "o", "c", "k", "s"]
  end

  test "state isn't changed for already :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game_state() |> Map.put(:game_state, state)
      assert { ^game, _tally } = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game_state()
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is flagged as already used" do
    game = Game.new_game_state()
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game_state("wibble")
    { game, _tally } = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "winning game progresses through all expected states" do
    game = Game.new_game_state("wibble")
    states = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"b", :already_used},
      {"l", :good_guess},
      {"e", :won},
    ]

    Enum.reduce(states, game,
      fn({guess, expected_state}, new_game_state) ->
	{new_game_state, _} = Game.make_move(new_game_state, guess)
	assert new_game_state.game_state == expected_state
	new_game_state
      end)
    
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.new_game_state("wibble")
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "losing game progresses through all expected states" do
    game = Game.new_game_state("wibble")
    states = [
      {"a", :bad_guess},
      {"c", :bad_guess},
      {"d", :bad_guess},
      {"f", :bad_guess},
      {"g", :bad_guess},
      {"h", :bad_guess},
      {"j", :lost},
    ]
    Enum.reduce(states, {game, game.turns_left},
      fn({guess, expected_state}, {new_game_state, turns_left}) ->
	assert new_game_state.turns_left == turns_left
	{new_game_state, _} = Game.make_move(new_game_state, guess)
	assert new_game_state.game_state == expected_state
	{ new_game_state, turns_left - 1 }
      end)
  end
end
