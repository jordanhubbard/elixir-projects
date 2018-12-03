defmodule DictionaryTest do

  use ExUnit.Case
  doctest Dictionary

  test "Make sure basic dictionary file handling is correct" do
    assert length(Dictionary.word_list) > 0
  end

  test "Verifies that a known word can be fetched from Dictionary" do
    assert "monkey" in Dictionary.word_list()
  end

  test "Look for a word near end of Dictionary to assure no truncation" do
    assert "zebra" in Dictionary.word_list()
  end

  test "Verify that a random word selected is string of non-zero length" do
    assert Dictionary.random_word() |> String.length() > 0
  end

end
