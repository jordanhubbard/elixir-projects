defmodule Benchmark do
  def measure(function) do
    function |> :timer.tc |> elem(0) |> Kernel./(1_000_000)
  end

  def open_and_read(fname) do
    measure(fn -> File.open(fname) |> elem(1) |> IO.read(:all) end)
  end

  def open_and_binread(fname) do
    measure(fn -> File.open(fname) |> elem(1) |> IO.binread(:all) end)
  end

  def just_read(fname) do
    measure(fn -> File.read!(fname) end)
  end

end

IO.puts("Time to open and read #{Benchmark.open_and_read("/usr/share/dict/words")} seconds")
IO.puts("Time to open and binread #{Benchmark.open_and_binread("/usr/share/dict/words")} seconds")
IO.puts("Time to just read #{Benchmark.just_read("/usr/share/dict/words")} seconds")
