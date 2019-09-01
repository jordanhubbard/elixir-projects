defmodule Hailstone do

  defp show(n), do: IO.puts(Kernel.trunc(n))
  
  # Even number
  defp calc(n, count) when rem(n, 2) == 0 and count > 0 do
    show(n)
    calc(n / 2, count - 1)
  end

  # Odd number
  defp calc(n, count) when count > 0 do
    show(n)
    calc((n * 3) + 1, count - 1)
  end

  defp calc(_n, _count), do: :done

  def do_calc(n) do
    calc(n, 10)
  end
end
