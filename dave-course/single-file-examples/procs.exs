defmodule Procs do
  def greeter(what, count) do
    receive do
      :exit ->
	IO.puts("I am out of here sir")
	exit(:normal)

      :reset ->
	greeter(what, 0)

      {:add, n} ->
	greeter(what, count + n)

      {:sub, n} ->
	greeter(what, count - n)

      msg ->
	IO.puts("#{count}: #{what} #{msg}")
	greeter(what, count + 1)
    end
  end
end

