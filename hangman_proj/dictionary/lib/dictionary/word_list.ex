require Logger

defmodule Dictionary.WordList do
  @thisAgent	__MODULE__

  def start_link() do
    Agent.start_link(&word_list/0, name: @thisAgent)
  end

  def random_word() do
    Agent.get(@thisAgent, &Enum.random/1)
  end

  def word_list() do
    word_file()
    |> File.open()
    |> read_file()
    |> String.split("\n")
  end

  defp word_file do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
  end

  defp read_file({ :ok, file }) do
    file
    |> IO.binread(:all)
  end

  defp read_file({ :error, reason }) do
    Logger.error "Word file #{word_file()} failed to read: #{reason}"
    {:error, reason}
  end

end
