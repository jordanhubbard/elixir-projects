defmodule Fib do

  def start() do
    {:ok, pid } = Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
    pid
  end

  def stop(pid) do
    Agent.stop(pid)
  end
    
  def calc(agent, n) do
    case Agent.get(agent, &(&1)) |> Map.get(n) do
      nil ->
	entry = calc(agent, n - 1) + calc(agent, n - 2)
	Agent.update(agent, fn(c) -> Map.put(c, n, entry) end)
	entry
      value ->
	value
    end
  end

  def slow_calc(0), do: 0
  def slow_calc(1), do: 1
  def slow_calc(n), do: slow_calc(n - 1) + slow_calc(n - 2)
end
