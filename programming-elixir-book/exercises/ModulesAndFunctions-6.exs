defmodule Chop do
  def try_guess(guess, answer, range) where guess == answer do
    IO.puts("Guessed #{guess}!")
  end

  def try_guess(guess, answer, range) where guess < answer do
    IO.puts "It's less"
  end
 
  def guess(actual, range) do
    low..high = range
    try_guess(low, div(high, 2), actual)
  end
end
