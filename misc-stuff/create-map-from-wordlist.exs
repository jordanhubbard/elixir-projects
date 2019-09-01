# This is my lame attempt to create an indexable map from a bunch of words.

defmodule WordyThing do
  def get_words(fname) do
    fname |> File.read!() |> String.split("\n")
  end

  def list_len([]), do: 0

  def list_len([_ | tail]) do
    1 + list_len(tail)
  end

  def map_from_words([]), do: %{}

  def map_from_words(word_list, set) do
    Enum.map(1..list_len(word_list), fn x -> MapSet.put() end)
  end
end
