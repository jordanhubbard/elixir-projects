# Simple utility module for some extra list operations
defmodule Lists do
  def list_len([]), do: 0

  def list_len([_ | tail]) do
    1 + list_len(tail)
  end

  def range(from, to) when from > to do
    []
  end

  def range(from, to) do
    [from | range(from + 1, to)]
  end

  def positive([]), do: []

  def positive([head | tail]) when head > 0 do
    [head | positive(tail)]
  end

  def positive([_ | tail]) do
    positive(tail)
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

# Benchmark the Ackermann function
defmodule Ackermann do
  @doc """
  Given values of m and n, compute the Ackermann function for them.  It
  also supports the concept of scheduling the computation as a task.
  """

  # Schedule the computation as a task.
  def ack_task(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :ack, m, n, client } ->
        send client, { :answer, m, n, Benchmark.measure(fn -> ack(m, n) end), self() }
        ack_task(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  def ack(0, n), do: n + 1
  def ack(m, 0), do: ack(m - 1, 1)
  def ack(m, n), do: ack(m - 1, ack(m, n - 1))
end

# Benchmark the 8queens problem.
defmodule Queens do
  @doc """
  Given n number of queens and m the size of the checkerboard, find all
  solutions to position each queen so that it does not collide with any other
  queen vertically, horizontally or diagonally.
  """

  # Schedule the computation as a task.
  def queens_task(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :queens, m, n, client } ->
        send client, { :answer, m, n, Benchmark.measure(fn -> queens(m, n) end), self() }
        queens_task(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  def queens(0, _m), do: [[]]
  def queens(n, m) do
    for done_queens <- queens(n-1, m),
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

# Some assorted random benchmarks.
defmodule BasicBenchmarks do
  @doc """
  Some miscellaneous and assorted benchmark functions which provide some
  type of memory or CPU load, without constituting any specific algorithm.
  """
  @sz 10000000

  # Schedule any computation as a task.
  def basic_benchmarks_task(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :create_and_walk, m, n, client } ->
        send client, { :answer, Benchmark.measure(fn -> create_and_walk() end), self() }
        create_and_walk(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  def create_and_walk do
    IO.write "Memory: Creating and walking a #{@sz} element list: "
    Lists.list_len(Lists.range(1, @sz))
  end
end

# OK, all of the tests entrypoints go in here.
defmodule DoTests do
   def benchmarks do
	spawn(BasicBenchmarks, :basic_benchmarks_task, self())
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
monitors = Enum.map((1..13), &(DoTests.make_queens_task(&1)))
Enum.map(monitors, fn(ref) ->
	receive do
  		{:DOWN, ^ref, _, _, _} -> IO.write("")
	end
	end)

IO.puts "Done"
#exit(:shutdown)
