require Logger

defmodule Dictionary do
  alias Dictionary.WordList

  defdelegate word_list(),	to: WordList
  defdelegate random_word(),	to: WordList

end
