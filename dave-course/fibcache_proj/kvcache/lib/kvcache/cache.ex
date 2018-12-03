defmodule KVCache.Cache do
  @thisAgent __MODULE__
  
  def start_link() do
    Agent.start_link(fn -> %{} end, name: @thisAgent)
  end

  def get(key) do
    Agent.get(@thisAgent, &(&1)) |> Map.get(key)
  end

  def set(key, value) do
    Agent.update(@thisAgent, fn(cache) -> Map.put(cache, key, value) end)
    value
  end
end
