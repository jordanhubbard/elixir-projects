# Simple utility module for some extra list operations

defmodule Lists do
  @spec list_len(list()) :: integer()
  def list_len([]), do: 0

  def list_len([_ | tail]) do
    1 + list_len(tail)
  end

  @spec range(integer(), integer()) :: list()
  def range(from, to) when from > to do
    []
  end

  def range(from, to) do
    [from | range(from + 1, to)]
  end

  @spec positive(list()) :: list()
  def positive([]), do: []

  def positive([head | tail]) when head > 0 do
    [head | positive(tail)]
  end

  def positive([_ | tail]) do
    positive(tail)
  end
end

# Ackermann function
defmodule Ackermann do
  def ack(0, n), do: n + 1
  def ack(m, 0), do: ack(m - 1, 1)
  def ack(m, n), do: ack(m - 1, ack(m, n - 1))
end

# Solve the 8queens problem.
defmodule Queens do
  @doc """
  Given n number of queens and m the size of the checkerboard, find all solutions to 
  position each queen so that it does not collide with any other queen vertically, 
  horizontally or diagonally.
  """
  def solve(0, _m), do: [[]]
  def solve(n, m) do
    for done_queens <- solve(n-1, m),
        avail_pos <- (Enum.to_list(1..m) -- done_queens),
        safe_pos(avail_pos, done_queens, 1), 
      do: [avail_pos | done_queens]
  end

  defp safe_pos(_, [], _), do: true
  defp safe_pos(pos, [queen | queens], distance) do
    (pos != queen + distance) and 
    (pos != queen - distance) and 
    safe_pos(pos, queens, distance+1)
  end
end

# Run a function while measuring its execution time.
defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end

# OK, all of the tests go in here.
defmodule DoTests do
   @sz 10000000
   def basic_benchmark do
	IO.write "Memory: Creating and walking a #{@sz} element list: "
	IO.puts "#{Benchmark.measure(fn -> Lists.list_len(Lists.range(1, @sz)) end)} seconds"
	IO.write "CPU: Solving single 8 queens problem for 13x13 board: "
	IO.puts "#{Benchmark.measure(fn -> Queens.solve(13, 13) end)} seconds"
	IO.write "CPU: Solving Ackermann function for 3,11: "
	IO.puts "#{Benchmark.measure(fn -> Ackermann.ack(3, 11) end)} seconds"
   end

   # This is the task receiver for an async test.
   def receive_task do
	receive do
	  {m, n} -> IO.puts "Task for #{m}x#{n} board ran #{Benchmark.measure(fn -> Queens.solve(m, n) end)} seconds"
	end
   end

   def make_queens_task(m) do
	p = spawn(DoTests, :receive_task, [])
	send(p, {m, m})
	Process.monitor(p)
   end

end

DoTests.basic_benchmark()
#DoTests.calculatePi()

IO.puts "CPU: Solving for multiple 8 queens problem in parallel, 1x1 -> 13x13"
monitors = Enum.map((1..13), fn(x) -> DoTests.make_queens_task(x) end)
Enum.map(monitors, fn(ref) ->
	receive do
  		{:DOWN, ^ref, _, _, _} -> IO.write("")
	end
	end)

IO.puts "Done"
exit(:shutdown)
