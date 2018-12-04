defmodule Fizz do
  def buzz(x, y, z) do
    buzzfunc = fn
      (0, 0, _) -> "FizzBuzz"
      (0, _, _) -> "Fizz"
      (_, 0, _) -> "Buzz"
      (_, _, x) -> x
    end
    buzzfunc.(x, y, z)
  end

  def monster(n) do
    buzz(rem(n, 3), rem(n, 5), n)
  end
  
end

