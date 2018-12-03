defmodule TextClient.Prompter do
  def accept_move(game) do
    IO.gets("Your guess: ")
    |> check_input(game)
  end

  defp check_input({:error, reason}, _) do
    IO.puts("Game ended prematurely: #{reason}")
    exit(:normal)
  end
    
  defp check_input(:eof, _) do
    IO.puts("You gave up")
    exit(:normal)
  end

  defp check_input(input, game) do
    input = String.trim(input)
    cond do
      input =~ ~r/\A[a-z]\z/ ->
	Map.put(game, :guess, input)
      true ->
	IO.puts("Please enter a valid character.")
	accept_move(game)
    end
  end
end
