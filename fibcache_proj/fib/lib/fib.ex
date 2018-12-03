defmodule Fib do

  def calc(0) do
    KVCache.set(0, 0)
  end
  
  def calc(1) do
    KVCache.set(1, 1)
  end
  
  def calc(n) do
    case KVCache.get(n) do
      nil ->
	KVCache.set(n, calc(n - 1) + calc(n - 2))

      value ->
	value
    end
  end

end
