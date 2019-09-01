f = fn a ->
  case a do
    {1, 2, 3} -> "Hi there you are boring"
    {2, 3, 4} -> "Less boring now"
    {2, x, 5} when x > 3 -> "Whoa fancy use of #{x}"
    _ -> "I have no idea"
  end
end

IO.puts("My function says to you: " <> f.({2, 9, 5}))
IO.puts("Are we having fun yet")
