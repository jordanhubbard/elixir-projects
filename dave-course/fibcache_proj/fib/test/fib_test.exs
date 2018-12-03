defmodule FibTest do
  use ExUnit.Case
  doctest Fib

  test "Fibonacci constants work" do
    assert Fib.calc(0) == 0
    assert Fib.calc(1) == 1
  end

  test "Small Fibonacci numbers work" do
    assert Fib.calc(10) == 55
  end
  
  test "Large Fibonacci numbers work" do
    assert Fib.calc(100) == 354224848179261915075
  end
end
