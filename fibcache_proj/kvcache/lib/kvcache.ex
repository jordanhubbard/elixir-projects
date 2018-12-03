defmodule KVCache do
  @moduledoc """
  Generic Key/Value cache agent implemented as an application.
  """

  @doc """
  Agent-based cache module which supports simple get and set functions.

  ## Examples

      iex> KVCache.get(:no_such_key)
      nil
      iex> KVCache.set(:monkeys, "butt")
      "butt"
      iex> KVCache.get(:monkeys)
      "butt"

  """

  alias KVCache.Cache

  defdelegate get(key),		to: Cache
  defdelegate set(key, value),	to: Cache
  
end
