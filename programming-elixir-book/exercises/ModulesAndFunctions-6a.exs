defmodule GuessGame do

  def main do
     IO.puts("I am thinking of a number between 1 and 10.  Guess it!")
     guess(Enum.random(1..10))
  end

  def guess(random_number) do
     user_input = (IO.gets("Your guess: ") |> String.trim |> String.to_integer)
     if user_input > random_number do
	IO.puts "Too high!"
	guess(random_number)
     end
     if user_input < random_number do
	IO.puts "Too low!"
	guess(random_number)
     end
     if user_input == random_number, do: IO.puts "Good guess!"
  end

end
