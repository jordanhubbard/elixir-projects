defmodule TestModule do
   def reduce([], value, _), do: value

   def reduce([head | tail], value, func) do
     reduce(tail, func.(head, value), func)
   end

   def mapsum([], _), do: 0

   def mapsum([head | tail], func) do
     func.(head) + mapsum(tail, func)
   end

   defp maxp(maxvalue, []), do: maxvalue

   defp maxp(maxvalue, [head | tail]) do
      if maxvalue < head do
	 maxp(head, tail)
      else
	 maxp(maxvalue, tail)
      end
   end

   def max(list), do: maxp(0, list)

   def swap([]), do: []
   def swap([_]), do: raise "Can't swap an odd number of elements"
   def swap([a, b | tail]), do: [b, a | swap(tail)]

end
