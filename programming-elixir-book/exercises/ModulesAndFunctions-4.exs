defmodule Math do

  def fact(0), do: 1
  def fact(n) when is_integer(n) do
    if n < 0 do
      raise "Negative number passed to factorial"
    else
      n * fact(n - 1)
    end
  end
  
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)

  def gcd(x,0), do: x
  def gcd(x,y), do: gcd(y, rem(x,y))
end
